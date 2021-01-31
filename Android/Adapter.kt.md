# RecycleView Cell Adapter

[Adapters][1] provide a binding from an app-specific data set to views that are displayed within a `RecyclerView`.

[1]:https://developer.android.com/reference/kotlin/androidx/recyclerview/widget/RecyclerView.Adapter

```kotlin
package <package>

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class RecipeAdapter : RecyclerView.Adapter<RecipeAdapter.ViewHolder>  {

    private var mDataset: ArrayList<Recipe>  // RecyclerView data

    class ViewHolder : RecyclerView.ViewHolder {
        var viewGroup: ViewGroup? = null
        constructor(v: ViewGroup?) : super(v!!) {
            viewGroup = v
        }
    }

    //adapter contructor, takes list of data
    constructor(myDataset: ArrayList<Recipe>/*, mContext: Context?*/){
        mDataset = myDataset
        //mContenxt = mContext
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v : ViewGroup = LayoutInflater.from(parent.context).inflate(R.layout.view_recipe_item, parent, false) as ViewGroup

        val vh = ViewHolder(v)
        return  vh
    }

    override fun getItemCount(): Int {
        return mDataset.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        val mItem : Recipe = mDataset.get(position)

        val titleText = holder.viewGroup?.findViewById<TextView>(R.id.titleText)
        titleText?.text = mItem.title

        Log.d("Adapter","Title: "+mItem.title)

        val deleteButton = holder.viewGroup!!.findViewById<Button>(R.id.deleteButton)
        deleteButton.setOnClickListener { removeItem(position) }

        //Click
        holder.viewGroup?.setOnClickListener {
            mListener?.select(position)
        }
    }



    private fun removeItem(position: Int) {
        mDataset.removeAt(position)
        notifyItemRemoved(position)
        notifyItemRangeChanged(position, mDataset.size)
    }

    /*
     *       Callback
     * */
    private var mListener: AdapterCallback? = null

    interface AdapterCallback {
        fun select(position: Int)
    }

    fun setOnCallback(mItemClickListener: AdapterCallback) {
        this.mListener = mItemClickListener
    }
}
```

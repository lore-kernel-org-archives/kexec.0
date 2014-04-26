Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WduI4-0001Ep-I7
 for kexec@lists.infradead.org; Sat, 26 Apr 2014 04:32:41 +0000
Message-ID: <535B36A9.6000901@huawei.com>
Date: Sat, 26 Apr 2014 12:31:37 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: code cleanup: set_bitmap
References: <0910DD04CBD6DE4193FCF86B9C00BE97205CAA@BPXM01GP.gisp.nec.co.jp>	<1398330673-23016-1-git-send-email-wangnan0@huawei.com>	<20140424112815.398f9852@hananiah.suse.cz>	<5359F1C3.5030100@huawei.com>
 <20140425100305.501177cb@hananiah.suse.cz>
In-Reply-To: <20140425100305.501177cb@hananiah.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, Geng Hui <hui.geng@huawei.com>

On 2014/4/25 16:03, Petr Tesarik wrote:
> On Fri, 25 Apr 2014 13:25:23 +0800
> Wang Nan <wangnan0@huawei.com> wrote:
> 
>> On 2014/4/24 17:28, Petr Tesarik wrote:
>>> On Thu, 24 Apr 2014 17:11:13 +0800
>>> Wang Nan <wangnan0@huawei.com> wrote:
>> [...]
>>>>  set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
>>>>      int val)
>>>>  {
>>>> @@ -3317,20 +3345,11 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
>>>>  	old_offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
>>>>  	new_offset = bitmap->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
>>>
>>> After applying this patch, both old_offset and new_offset are
>>> calculated only to compare for equality. And new_offset is in fact
>>> computed twice (once in set_bitmap and once in sync_bitmap).
>>>
>>> This could be cleaned up by replacing the offsets with:
>>>
>>> 	int new_no_block = pfn / PFN_BUFBITMAP;
>>>
>>> Then change all occurrences of if (old_offset != new_offset) to:
>>>
>>> 	if (bitmap->no_block != new_no_block)
>>>
>>> and finally re-use new_no_block in the assignment to bitmap->no_block
>>> near the end of the function, like this:
>>>
>>> -		bitmap->no_block = pfn / PFN_BUFBITMAP;
>>> +		bitmap->no_block = new_no_block;
>>>
>>> Petr T
>>>
>>>>  
>>>> -	if (0 <= bitmap->no_block && old_offset != new_offset) {
>>>> -		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
>>>> -			ERRMSG("Can't seek the bitmap(%s). %s\n",
>>>> -			    bitmap->file_name, strerror(errno));
>>>> -			return FALSE;
>>>> -		}
>>>> -		if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
>>>> -		    != BUFSIZE_BITMAP) {
>>>> -			ERRMSG("Can't write the bitmap(%s). %s\n",
>>>> -			    bitmap->file_name, strerror(errno));
>>>> +	if (old_offset != new_offset) {
>>>> +		if (!sync_bitmap(bitmap)) {
>>>> +			ERRMSG("Can't sync bitmap\n");
>>>>  			return FALSE;
>>>>  		}
>>>> -	}
>>>> -	if (old_offset != new_offset) {
>>>>  		if (lseek(bitmap->fd, new_offset, SEEK_SET) < 0 ) {
>>>>  			ERRMSG("Can't seek the bitmap(%s). %s\n",
>>>>  			    bitmap->file_name, strerror(errno));
>> [ .. see below .. ]
>>
>> Good suggestion, but new_offset is still needed to be calculated for these lseeks.
> 
> True, but it will be calculated only once (in sync_bitmap). OTOH the
> block number is always needed, because it is stored in bitmap->no_block.
> 
> Okay, that can be changed, and you can store the offset instead. I
> don't have a strong opinion on this.
> 
>> In addition, I have another idea: what about to replace all lseek .. read/write pattern to pread/pwrite?
> 
> Definitely! After doing that, we could even reuse the same file descriptor
> for all processes.
> 

I posted a series of patches for lseek. If Atsushi Kumagai accept them, I will
redo this patch on top of them.

> Now, since the original patch looks good as it is, let's see if Atsushi
> Kumagai takes it into the tree and post more clean up patches afterwards.
> 
> Petr T
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

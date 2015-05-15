Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yt7cP-00005Y-GD
 for kexec@lists.infradead.org; Fri, 15 May 2015 04:53:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using
 bitmap file.
Date: Fri, 15 May 2015 04:51:19 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA325@BPXM01GP.gisp.nec.co.jp>
 <20150512.172035.461774614.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DAB6F8@BPXM01GP.gisp.nec.co.jp>
 <20150514.100843.320775105.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20150514.100843.320775105.d.hatayama@jp.fujitsu.com>
Content-Language: ja-JP
Content-Type: multipart/mixed;
 boundary="_002_0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5BPXM01GPgispnec_"
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--_002_0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5BPXM01GPgispnec_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

>>>How about compromising progress information to some extent? The first
>>>pass is intended to count up the exact number of dumpable pages just
>>>to provide precise progress information. Is such prcision really
>>>needed?
>>
>> The first pass counts up the num_dumpable *to calculate the offset of
>> starting page data region in advance*, otherwise makedumpfile can't star=
t
>> to write page data except create a sparse file.
>>
>>    7330 write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header=
, struct cache_data *cd_page)
>>    7331 {
>>    7332         struct page_desc pd_zero;
>>    7333         off_t offset_data=3D0;
>>    7334         struct disk_dump_header *dh =3D info->dump_header;
>>    7335         unsigned char buf[info->page_size];
>>    7336         struct timeval tv_start;
>>    7337
>>    7338         /*
>>    7339          * Reset counter for debug message.
>>    7340          */
>>    7341         pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
>>    7342         pfn_user =3D pfn_free =3D pfn_hwpoison =3D 0;
>>    7343         pfn_memhole =3D info->max_mapnr;
>>    7344
>>    7345         cd_header->offset
>>    7346                 =3D (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size +=
 dh->bitmap_blocks)
>>    7347                 * dh->block_size;
>>    7348         cd_page->offset =3D cd_header->offset + sizeof(page_desc=
_t)*info->num_dumpable;
>>    7349         offset_data =3D cd_page->offset;                        =
          ^^^^^^^^^^^^
>>
>>
>
>I overlooked this, sorry.
>
>Size of page description header is 24 bytes. This corresponds to 6 GB
>per 1 TB. Can this become a big problem? Of course, I think it odd
>that page description table could be larger than memory data part.

At least, it looks that the member "page_flags" can be removed since
makedumpfile always just set 0 to it and crash doesn't refer it.

  typedef struct page_desc {
	off_t offset; 				/* the offset of the page data*/
	unsigned int size; 			/* the size of this dump page */
	unsigned int flags; 			/* flags */
	unsigned long long page_flags; 		/* page flags */  <--- always 0, this 8 b=
yte is useless.
  } page_desc_t;


(Sorry for getting off track here)
Further, I have another idea that would reduce the total size
of page descriptor. That is assigning a page descriptor to a number
of pages, it means multiple pages will be managed as a data block.

The original purpose of the idea is improving compressive performance
by compressing some pages in a lump.
We know the compression with zlib is too slow. I suspect that one of
the causes is the buffer size for compress2().
When compressing a 100MB file, I expect that compressing 10MB block 10 time=
s
will be faster than compressing 1MB block 100 times.
Actually I did simple verification with the attached program like:

  # ./zlib_compress 1024 testdata
  TOTAL COMPRESSION TIME: 18.478064
  # ./zlib_compress 10240 testdata
  TOTAL COMPRESSION TIME: 5.940524
  # ./zlib_compress 102400 testdata
  TOTAL COMPRESSION TIME: 2.088867
  #

Unfortunately I haven't had a chance to work for it for a long time,
but I think it would be better to consider it together if we design
a new dump format.

>There's another aproach: construct the page description table at each
>cycle separately over a dump file and connect them by a linked list.
>
>This changes dump format and needs to add crash utility support; no
>compatibility to current crash utility.

It's interesting. I think we should improve the format if there is a
good reason, the format shouldn't be an obstacle.
Of course, the new format should be an option at first, but it would
be great if there is a choice to get better performance.


Thanks
Atsushi Kumagai

>>>For example, how about another simple progress information:
>>>
>>>   pfn / max_mapnr
>>>
>>>where pfn is the number of a page frame that is currently
>>>processed. We know max_mapnr from the beginning, so this is possible
>>>within one pass. It's less precise but might be precise enough.
>>
>> I also think it's enough for progress information, but anyway the 1st
>> pass is necessary as above.
>>
>>
>> Thanks
>> Atsushi Kumagai
>--
>Thanks.
>HATAYAMA, Daisuke

--_002_0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5BPXM01GPgispnec_
Content-Type: text/plain; name="zlib_compress.c"
Content-Description: zlib_compress.c
Content-Disposition: attachment; filename="zlib_compress.c"; size=1243;
	creation-date="Mon, 08 Jul 2013 23:40:14 GMT";
	modification-date="Wed, 08 Aug 2012 08:40:20 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHpsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxmY250
bC5oPgojaW5jbHVkZSA8c3lzL3RpbWUuaD4KCgpzdGF0aWMgaW5saW5lIGRvdWJsZSBnZXRkdGlt
ZSh2b2lkKQp7CglzdHJ1Y3QgdGltZXZhbCB0djsKCglnZXR0aW1lb2ZkYXkoJnR2LCBOVUxMKTsK
CglyZXR1cm4gKGRvdWJsZSl0di50dl9zZWMgKyAoZG91YmxlKXR2LnR2X3VzZWMgKiAwLjAwMSAq
IDAuMDAxOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqIGFyZ3ZbXSkgewoJY2hhciAqYnVm
X2luLCAqYnVmX291dDsKCXVuc2lnbmVkIGxvbmcgc2l6ZV9pbiwgc2l6ZV9vdXQ7CglpbnQgZmQ7
Cglkb3VibGUgZF9zdGFydCwgZF9lbmQsIGRfY29tcHJlc3M7CgkKCWlmIChhcmdjICE9IDMpIHsK
CQlwcmludGYoIi4vY29tbWFuZCA8c2l6ZV9pbj4gPGlucHV0IGZpbGU+XG4iKTsKCQlleGl0KDEp
OwoJfQoKCWRfY29tcHJlc3MgPSAwOwoKCS8vIGJ1ZmZlciBmb3IgaW5wdXQgZGF0YQoJc2l6ZV9p
biA9IGF0b2koYXJndlsxXSk7CglidWZfaW4gPSAoY2hhciAqKW1hbGxvYyhzaXplX2luKTsKCglp
ZiAoIWJ1Zl9pbikgewoJCXByaW50ZigibWFsbG9jIGZhaWxlZC4gJW4gYnl0ZW4iLCBzaXplX2lu
KTsKCQlleGl0KDEpOwoJfQoKCS8vIGJ1ZmZlciBmb3Igb3V0cHV0IGRhdGEKCXNpemVfb3V0ID0g
Y29tcHJlc3NCb3VuZChzaXplX2luKTsKCWJ1Zl9vdXQgPSAoY2hhciAqKW1hbGxvYyhzaXplX291
dCk7CgoJaWYgKCFidWZfb3V0KSB7CgkJcHJpbnRmKCJtYWxsb2MgZmFpbGVkLiAlbiBieXRlbiIs
IHNpemVfb3V0KTsKCQlleGl0KDEpOwoJfQoKCWlmICgoZmQgPSBvcGVuKGFyZ3ZbMl0sIE9fUkRP
TkxZKSkgPT0gMCkgewoJCXByaW50ZigiZmlsZSBvcGVuIGZhaWxlZC4gJXNcbiIsIGFyZ3ZbMl0p
OwoJCWV4aXQoMSk7Cgl9CgoJd2hpbGUgKHJlYWQoZmQsIGJ1Zl9pbiwgc2l6ZV9pbikpIHsKCQlk
X3N0YXJ0ID0gZ2V0ZHRpbWUoKTsKCQljb21wcmVzczIoYnVmX291dCwgJnNpemVfb3V0LCBidWZf
aW4sIHNpemVfaW4sIFpfQkVTVF9TUEVFRCk7CgkJZF9lbmQgPSBnZXRkdGltZSgpOwoJCWRfY29t
cHJlc3MgKz0gZF9lbmQgLSBkX3N0YXJ0OwoJfQoKCXByaW50ZigiVE9UQUwgQ09NUFJFU1NJT04g
VElNRTogJWxmXG4iLCBkX2NvbXByZXNzKTsKCXJldHVybiAwOwp9CgoJCSAgCg==

--_002_0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5BPXM01GPgispnec_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--_002_0910DD04CBD6DE4193FCF86B9C00BE9701DB44B5BPXM01GPgispnec_--


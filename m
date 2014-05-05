Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhHve-0003IJ-GX
 for kexec@lists.infradead.org; Mon, 05 May 2014 12:23:31 +0000
Message-ID: <53678261.1000006@huawei.com>
Date: Mon, 5 May 2014 20:21:53 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] zImage-arm: get rid of static offset
References: <1398940925-11769-1-git-send-email-zonque@gmail.com>
 <20140502021105.GF2265@verge.net.au>
In-Reply-To: <20140502021105.GF2265@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>, Daniel Mack <zonque@gmail.com>
Cc: kexec@lists.infradead.org, s.neumann@raumfeld.com

On 2014/5/2 10:11, Simon Horman wrote:
> On Thu, May 01, 2014 at 12:42:05PM +0200, Daniel Mack wrote:
>> The code in arch/arm/kexec-zImage-arm.c currently enforces a hard limit
>> on the maximum size a dtb blob can occupy. This limit is set to 32k,
>> which is quite low for device tree blobs nowadays.
>>
>> Get rid of this assumption, and calculate the added size dynamically.
>> For this, we need to slurp in the dtb file earlier in order to
>> determine its size, because the memory hole allocation for 'base'
>> takes this size into account.
>>
>> For ATAGs, we keep the current value of 32k, which should in fact be
>> enough.
>>
>> With this change in place, the 'DTB too large!' error message can go
>> away. Successfully tested on a AM335x board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> [s.neumann@raumfeld.com: Fix ATAGs case]
>> Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
>> ---
>> v2 includes a fixup from Sven Neumann for ATAGs driven boards.
>> The patch is in tested on a larger number of machines by now.
> 
> Thanks, applied.
> 

After applying this patch, the second kernel on qemu never works. I have
posted a patch on it to solve this problem:

 [kexec-tools][PATCH] zImage-arm: bugfix: load kernel at TEXT_OFFSET

I think there must be some misunderstanding about "DTB too large!" problem.
DTB is pasted after initrd by kexec, not before the kernel. See following figures:

When using DTB:

|<--- TEXT_OFFSET (0x8000) ------->|
|<-- atags, DTB *is not here* ---->|<-- zImage -->|<-- initrd -->|<-- *DTB is here* -->|

When using ATAGS:

|<-- TEXT_OFFSET (0x8000) ->|
|<-- 0x1000 --|<-- atags -->|<-- zImage -->|<-- initrd -->|

It seems the original code is incorrect:

      if (base + atag_offset + dtb_length > base + offset) { // offset is TEXT_OFFSET
              fprintf(stderr, "DTB too large!\n");
              return -1;
      }

This code assumes dtb is loaded between atags_offset and zImage, can use only 28KiB memory,
same as atags. However, dtb is loaded after initrd, no upper limit is taken place, so simply
remove the above checking is enough. In my patch, I use locate_holes() to endure there is enough
space for initrd and dtb.

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

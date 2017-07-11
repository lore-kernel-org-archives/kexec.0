Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dUxrb-0005G8-PP
 for kexec@lists.infradead.org; Tue, 11 Jul 2017 16:18:17 +0000
Received: by mail-qk0-x22f.google.com with SMTP id d78so6996472qkb.1
 for <kexec@lists.infradead.org>; Tue, 11 Jul 2017 09:17:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EEE856@BPXM01GP.gisp.nec.co.jp>
References: <CAEzMDiD-w91Q+Fjy_KgXDcwo9YGasa9ggqW2dEhF4ffV7RstqQ@mail.gmail.com>
 <0bd0a35a-88cd-3f68-846f-2a2ad1e7afcb@redhat.com>
 <CAEzMDiBKdA15Gn2kgs=BgzCM=bzaBXCQP_tM_Vmfc4uxGL0SRg@mail.gmail.com>
 <0ae1e066-821e-3b11-ee44-b615245cb1ea@redhat.com>
 <3b72a75c-012e-2779-74a4-d36ca1ef9e56@redhat.com>
 <CAEzMDiARnp-FMqUcoVdCBSSApaRbenvrk7cawgyo8kJJvy0jXg@mail.gmail.com>
 <364d6133-158b-0f28-0278-dc0da33b2916@redhat.com>
 <CAEzMDiAq1U3SRkvwh5nqETDBoZs8DojhmMTDSG7B-Uzbh1a3Nw@mail.gmail.com>
 <148b498a-cd13-bcb2-de04-d74b1c2a0f65@redhat.com>
 <CAEzMDiBU98VzS9Yye6UrCVM5-f9F64ZUqCOJPpnd+5ufdY5OsA@mail.gmail.com>
 <CAEzMDiAJwLXHRqF9whvRoXw3Va47X-2M1=v0cTK6RqvMZLb91Q@mail.gmail.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EEE856@BPXM01GP.gisp.nec.co.jp>
From: Abhishek Shah <abrs612@gmail.com>
Date: Tue, 11 Jul 2017 21:47:52 +0530
Message-ID: <CAEzMDiDMx=AD3O_4Jc9BWmo2Tumw4eS--4K3khu9gUOM73Kstg@mail.gmail.com>
Subject: Re: makedumpfile: support for newer kernels [v4.9 onwards]
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Pratyush Anand <panand@redhat.com>, Dave Anderson <anderson@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>Seeing further, I could see that the "get_mem_map" function at the end
>>[if (!is_xen_memory())]
>>is attempting to change "info->max_mapnr" value based on "mem=" option.
>>-- in particular commit ebe2fa3a5c1e2bfac3778c0fbeca4287a934cc58.
>>And in my kernel command line, "mem=2G" was present, as I intended to
>>take dump of 2G RAM,
>>resulting into reduced "info->max_mapnr".
>
> Basically, this adjusting info->max_mapnr must be harmless since
> it just intends to ignore unused memory regions.
> Did you find out why adjusting info->max_mapnr causes the problem ?
>
Operation of "write_kdump_pages_and_bitmap_cyclic" depends on
info->max_mapnr value.
That is the reason why we have problem with kdump compressed dump, but
not with elf formatted dump.

From the memory regions that I have, the last region does not seem to
be mapped (which contains the address sought by crash);
because of which, info->max_mapnr is getting adjusted to some reduced
value (compared to the previous info->max_mapnr of 880203).

Following is the memory regions that I have:
mem_map (0)
  mem_map    : ffff8008000c6280
  pfn_start  : 0
  pfn_end    : 40000
mem_map (1)
  mem_map    : 0
  pfn_start  : 40000
  pfn_end    : 80000
mem_map (2)
  mem_map    : 0
  pfn_start  : 80000
  pfn_end    : c0000
mem_map (3)
  mem_map    : 0
  pfn_start  : c0000
  pfn_end    : 100000
mem_map (4)
  mem_map    : 0
  pfn_start  : 100000
  pfn_end    : 140000
mem_map (5)
  mem_map    : 0
  pfn_start  : 140000
  pfn_end    : 180000
mem_map (6)
  mem_map    : 0
  pfn_start  : 180000
  pfn_end    : 1c0000
mem_map (7)
  mem_map    : 0
  pfn_start  : 1c0000
  pfn_end    : 200000
mem_map (8)
  mem_map    : 0
  pfn_start  : 200000
  pfn_end    : 240000
mem_map (9)
  mem_map    : 0
  pfn_start  : 240000
  pfn_end    : 280000
mem_map (10)
  mem_map    : 0
  pfn_start  : 280000
  pfn_end    : 2c0000
mem_map (11)
  mem_map    : 0
  pfn_start  : 2c0000
  pfn_end    : 300000
mem_map (12)
  mem_map    : ffff800045136a80
  pfn_start  : 300000
  pfn_end    : 340000
mem_map (13)
  mem_map    : ffff800046136480
  pfn_start  : 340000
  pfn_end    : 380000
mem_map (14)
  mem_map    : ffff800047136c00
  pfn_start  : 380000
  pfn_end    : 3c0000
mem_map (15)
  mem_map    : 0
  pfn_start  : 3c0000
  pfn_end    : 400000
mem_map (16)
  mem_map    : 0
  pfn_start  : 400000
  pfn_end    : 440000
mem_map (17)
  mem_map    : 0
  pfn_start  : 440000
  pfn_end    : 480000
mem_map (18)
  mem_map    : 0
  pfn_start  : 480000
  pfn_end    : 4c0000
mem_map (19)
  mem_map    : 0
  pfn_start  : 4c0000
  pfn_end    : 500000
mem_map (20)
  mem_map    : 0
  pfn_start  : 500000
  pfn_end    : 540000
mem_map (21)
  mem_map    : 0
  pfn_start  : 540000
  pfn_end    : 580000
mem_map (22)
  mem_map    : 0
  pfn_start  : 580000
  pfn_end    : 5c0000
mem_map (23)
  mem_map    : 0
  pfn_start  : 5c0000
  pfn_end    : 600000
mem_map (24)
  mem_map    : 0
  pfn_start  : 600000
  pfn_end    : 640000
mem_map (25)
  mem_map    : 0
  pfn_start  : 640000
  pfn_end    : 680000
mem_map (26)
  mem_map    : 0
  pfn_start  : 680000
  pfn_end    : 6c0000
mem_map (27)
  mem_map    : 0
  pfn_start  : 6c0000
  pfn_end    : 700000
mem_map (28)
  mem_map    : 0
  pfn_start  : 700000
  pfn_end    : 740000
mem_map (29)
  mem_map    : 0
  pfn_start  : 740000
  pfn_end    : 780000
mem_map (30)
  mem_map    : 0
  pfn_start  : 780000
  pfn_end    : 7c0000
mem_map (31)
  mem_map    : 0
  pfn_start  : 7c0000
  pfn_end    : 800000
mem_map (32)
  mem_map    : 0
  pfn_start  : 800000
  pfn_end    : 840000
mem_map (33)
  mem_map    : 0
  pfn_start  : 840000
  pfn_end    : 880000
mem_map (34)
  mem_map    : 0
  pfn_start  : 880000
  pfn_end    : 880203

>>So, I commented out this portion and confirmed that "info->max_mapnr"
>>remains same
>>throughout. And I was able to get kdump compressed vmcore process-able
>>by crash utility.
>
> This sounds like there are some valid data beyond the adjusted info->max_mapnr,
> is that true ?
I am not sure about it, but crash does look for data in mem_map(34),
I haven't yet look into this in-detail. I will do that soon.


Regards,
Abhishek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

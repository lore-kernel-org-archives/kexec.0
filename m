Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHxRm-0008So-0U
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 15:27:58 +0000
In-Reply-To: <20140224152205.GC4631@redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
 <2680313.u921kQOFS9@skinner>
 <20140224145841.GE1262@dhcp-17-89.nay.redhat.com>
 <20140224152205.GC4631@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] kexec-tools, x86: E820 memmap pass for kdump
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 24 Feb 2014 07:27:15 -0800
Message-ID: <5458fa7d-ca13-4c2a-bd76-344ceb7679cb@email.android.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, jdmason@kudzu.us, dyoung@redhat.com, Thomas Renninger <trenn@suse.de>

I would like to see if there is any actual use for it before doing anything else.  The Calgary code may just be off.

On February 24, 2014 7:22:05 AM PST, Vivek Goyal <vgoyal@redhat.com> wrote:
>On Mon, Feb 24, 2014 at 10:58:41PM +0800, WANG Chao wrote:
>[..]
>> > Approaches to avoid saved_max_pfn in calgary case:
>> >   1) If done correctly from the beginning, the TCE table size would
>have
>> >      been exposed via /sys and kexec-tools could simply add:
>> >      calgary="128k|512K...|8M" which is already caught by
>pci-calgary and
>> >      saved_max_pfn is not needed/touched anymore.
>> >      -> Disadvantage: needs a new sysfs entry
>> >   2) When finding max_pfn for calgary table size usage, we could
>try in 
>> >      kdump case to use the highest memory (RAM or RESERVED) showing
>up
>> >      in e820 map.
>> 
>> How could this replace saved_max_pfn? The highest memory in kdump
>can't
>> necessarily be the real ram size. In kdump, RAM range is just part of
>the real
>> ram, not mentioning we don't pass RESERVED range to kdump E820.
>
>I vaguely remember there was some discussion about passing first
>kerne's
>RAM as special reserved ranges. Say E820_RESERVED_KDUMP. And use that
>to figure out saved_max_pfn.
>
>I personally feel that just create a new command line parameter
>"saved_max_pfn" and pass it to second kernel and be done with it.
>Modify
>calgary code to first look for saved_max_pfn and if not present,
>calculate
>saved_max_pfn from e820.
>
>saved_max_pfn command line option is pretty ugly, not sure what are the
>better options here.
>
>Thanks
>Vivek

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

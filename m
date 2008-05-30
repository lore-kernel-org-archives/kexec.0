Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K25mw-0006lu-Gm
	for kexec@lists.infradead.org; Fri, 30 May 2008 14:41:03 +0000
Message-ID: <484011FB.6010604@redhat.com>
Date: Fri, 30 May 2008 10:40:59 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Crash-utility] Re: [Xen-devel] [PATCH] Add xen_phys_start value
	in the crash info note
References: <C465CB32.2176B%keir.fraser@eu.citrix.com>
In-Reply-To: <C465CB32.2176B%keir.fraser@eu.citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: Itsuro ODA <oda@valinux.co.jp>, xen-devel@lists.xensource.com, kexec@lists.infradead.org

Keir Fraser wrote:
> On 30/5/08 06:13, "Itsuro ODA" <oda@valinux.co.jp> wrote:
>
>   
>> This patch makes the vmcore utilities (ex. crash, makedumpfile) be
>> able to get the relocation address of the xen hypervisor from a vmcore.
>> It is necessary for the utilities to find the data of the hypervisor
>> structures.
>>
>> Note that this patch does not raise any comptibility issue for the
>> utilities (which I know) nor the other components of xen.
>>     
>
> Since it both changes the size of the crash_info elf note, and adds the new
> field in the middle of the crash_info structure, how can it not affect
> compatibility?
>
>  -- Keir
>   

Itsuro did it that way on purpose.  It maintains backwards compatibility by
keeping the dom0_pfn_to_mfn_frame_list_list field as the last field in the
PT_NOTE.  crash doesn't know what a crash_xen_info_t structure is, but only
its old and new size.

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bwNjb-0000er-91
 for kexec@lists.infradead.org; Tue, 18 Oct 2016 06:18:49 +0000
Received: by mail-pf0-x235.google.com with SMTP id e6so88521150pfk.3
 for <kexec@lists.infradead.org>; Mon, 17 Oct 2016 23:18:24 -0700 (PDT)
Date: Tue, 18 Oct 2016 15:26:19 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v26 0/7] arm64: add kdump support
Message-ID: <20161018062617.GN19531@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <3400bddc-9c6e-b69a-b57d-62921197bef9@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3400bddc-9c6e-b69a-b57d-62921197bef9@cisco.com>
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
To: Ruslan Bilovol <rbilovol@cisco.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Ruslan,

On Mon, Oct 17, 2016 at 06:41:01PM +0300, Ruslan Bilovol wrote:
> Hi,
> 
> On 09/07/2016 07:29 AM, AKASHI Takahiro wrote:
> >     v26-specific note: After a comment from Rob[0], an idea of adding
> >     "linux,usable-memory-range" was dropped. Instead, an existing
> >     "reserved-memory" node will be used to limit usable memory ranges
> >     on crash dump kernel.
> >     This works not only on UEFI/ACPI systems but also on DT-only systems,
> >     but if he really insists on using DT-specific "usable-memory" property,
> >     I will post additional patches for kexec-tools. Those would be
> >     redundant, though.
> >     Even in that case, the kernel will not have to be changed.
> >
> >This patch series adds kdump support on arm64.
> >There are some prerequisite patches [1],[2].
> >
> >To load a crash-dump kernel to the systems, a series of patches to
> >kexec-tools, which have not yet been merged upstream, are needed.
> >Please always use my latest kdump patches, v3 [3].
> >
> >To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> >   - crash utility (coming v7.1.6 or later) [4]
> >     (Necessary patches have already been queued in the master.)
> >
> >
> >[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452582.html
> >[1] "arm64: mark reserved memblock regions explicitly in iomem"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
> >[2] "efi: arm64: treat regions with WT/WC set but WB cleared as memory"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451491.html
> >[3] T.B.D.
> >[4] https://github.com/crash-utility/crash.git
> 
> Are you going to rebase your patch series onto v4.9-rc1 tag soon? I see

Yes, definitely as soon as possible! (actually I've done it.)
But before submitting a new version, I need to convince Rob (Herring)
that he would accept my old approach (v25) regarding specifying usable
memory for crash dump kernel:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/459379.html 

> that patches [1] and [2] are already in v4.9-rc1, but when tried to apply
> this series, I've got conflict on first patch of the series ("arm64: kdump:
> reserve memory for crash dump kernel"). I want to try arm64 kdump
> patches again on my board, so I'm interested in this. The question is
> whether I need to rebase it myself or you will do the same (and address
> comments) soon.

Thank you for your interests and sorry for any inconvenience.

-Takahiro AKASHI

> Also I see Geoff published v6 of arm64 kexec-tools patches, so same
> question is applicable to "(kexec-tools) arm64: add kdump support"
> patch series.
> 
> Thanks,
> Ruslan
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

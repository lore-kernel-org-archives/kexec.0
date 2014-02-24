Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHxOl-0008Nv-HC
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 15:24:52 +0000
Date: Mon, 24 Feb 2014 10:24:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140224152427.GD4631@redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
 <2680313.u921kQOFS9@skinner>
 <20140224145841.GE1262@dhcp-17-89.nay.redhat.com>
 <7125bd4c-b394-4180-b564-f2002c9d9a2e@email.android.com>
 <20140224151103.GB4631@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140224151103.GB4631@redhat.com>
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
To: jdmason@kudzu.us
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, dyoung@redhat.com, Thomas Renninger <trenn@suse.de>, WANG Chao <chaowang@redhat.com>

On Mon, Feb 24, 2014 at 10:11:03AM -0500, Vivek Goyal wrote:
> On Mon, Feb 24, 2014 at 07:03:07AM -0800, H. Peter Anvin wrote:
> > First question is if Calgary even exists anymore and if so if someone actually cares about it enough to maintain it.
> 
> Atleast MAINTAINERS file says it is maintained.
> 
> CALGARY x86-64 IOMMU
> M:      Muli Ben-Yehuda <muli@il.ibm.com>
> M:      "Jon D. Mason" <jdmason@kudzu.us>
> L:      discuss@x86-64.org
> S:      Maintained
> F:      arch/x86/kernel/pci-calgary_64.c
> F:      arch/x86/kernel/tce_64.c
> F:      arch/x86/include/asm/calgary.h
> F:      arch/x86/include/asm/tce.h
> 
> 
> I am add maintainers to CC list and they can shed more light on if
> calgary still exists and if somebody actually cares about it.

Jon,

Muli's mail is bouncing. Is he still maintaining calgary and is his
mail id still valid as mentioned in MAINTAINERS entry above.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

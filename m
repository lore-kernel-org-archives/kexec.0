Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22c.google.com ([2607:f8b0:4001:c02::22c])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00yw-0003Tq-27
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:31:30 +0000
Received: by mail-ia0-f172.google.com with SMTP id u8so5210489iag.17
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2013 18:31:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4302d59f-5c87-4b82-af16-9f54625fc9ce@email.android.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de>
 <510721C6.6080705@zytor.com>
 <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
 <51072FEF.50000@zytor.com>
 <CAE9FiQVG4ShGKSdjzYhQaXNNhS=MVNJg=QqG1yW-mAUscErXMA@mail.gmail.com>
 <4302d59f-5c87-4b82-af16-9f54625fc9ce@email.android.com>
Date: Mon, 28 Jan 2013 18:31:28 -0800
Message-ID: <CAE9FiQUDP9x+6CZKyW8CVq7YWy+zQwSTqm67G-AuX0=LYgqf6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Mon, Jan 28, 2013 at 6:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> To be more clear: the max_pfn stuff seems like a relic of the past, and I am wondering what it would take to get rid of it.
>
> It clearly has the wrong semantics, except perhaps in the most trivial allocator models.
>
one thing i think could be : use that decide if we need iommu/swiotlb.
like in
arch/x86/kernel/amd_gart_64.c
arch/x86/kernel/pci-swiotlb.c
drivers/iommu/amd_iommu.c
...

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

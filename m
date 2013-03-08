Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDrhy-0007yY-D5
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 07:27:15 +0000
Received: by mail-oa0-f41.google.com with SMTP id i10so1677342oag.14
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2013 23:27:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51399154.5030500@redhat.com>
References: <51397D1D.5030602@redhat.com>
 <1750036321.11235774.1362722613994.JavaMail.root@redhat.com>
 <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
 <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
 <51399154.5030500@redhat.com>
Date: Thu, 7 Mar 2013 23:27:12 -0800
Message-ID: <CAE9FiQVPaG5P7mG9HoFzCkaxF62hkU5hEtq_FhdT7n+38aNs9A@mail.gmail.com>
Subject: Re: 3.9-rc1: crash kernel panic - not syncing: Can not allocate
 SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: CAI Qian <caiqian@redhat.com>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Mar 7, 2013 at 11:20 PM, WANG Chao <chaowang@redhat.com> wrote:
>>
>> looks like your system DO have DMAR table, please enable dmar
>> remapping in your kernel config.
>
> I've already got following config:
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_IRQ_REMAP=y
>
> but I don't have intel_iommu=on in kernel cmdline. IIRC, iommu will prevent
> 2nd kernel from booting ...

Did you put intel_iommu=on on first and second cpu both?

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

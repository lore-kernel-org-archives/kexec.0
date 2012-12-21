Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tm5JU-0006Sp-IK
 for kexec@lists.infradead.org; Fri, 21 Dec 2012 16:19:09 +0000
Received: by mail-bk0-f41.google.com with SMTP id jg9so2499583bkc.14
 for <kexec@lists.infradead.org>; Fri, 21 Dec 2012 08:19:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50B8D571.3000000@jp.fujitsu.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <50B8D571.3000000@jp.fujitsu.com>
Date: Fri, 21 Dec 2012 08:19:05 -0800
Message-ID: <CAE9FiQVaqXMfju5j7qBsk+g=RpES-adBBdrDcnkW=YQTQOfugQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
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
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, Thomas Renninger <trenn@suse.de>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Fri, Nov 30, 2012 at 7:49 AM, MUNEDA Takahiro
<muneda.takahiro@jp.fujitsu.com> wrote:
> On Tue, 27 Nov 2012 09:42:20 +0900 (JST),
> Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>
>> These patches reset PCIe devices at boot time to address DMA problem on
>> kdump with iommu. When "reset_devices" is specified, a hot reset is
>> triggered on each PCIe root port and downstream port to reset its
>> downstream endpoint.

ThomasR, Can you check if this one help your test case about interrupt ?

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

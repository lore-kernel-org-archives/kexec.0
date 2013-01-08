Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tscxx-0001gk-Ej
 for kexec@lists.infradead.org; Tue, 08 Jan 2013 17:27:58 +0000
Received: by mail-bk0-f45.google.com with SMTP id jk13so401369bkc.32
 for <kexec@lists.infradead.org>; Tue, 08 Jan 2013 09:27:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201301081750.07296.trenn@suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1593084.QhbTkmoq3N@hammer82.arch.suse.de>
 <CAE9FiQWTiFu0+ymVroK84L-LCc7FBU1trdZAcaXqMGM2My6LzQ@mail.gmail.com>
 <201301081750.07296.trenn@suse.de>
Date: Tue, 8 Jan 2013 09:27:55 -0800
Message-ID: <CAE9FiQXUCtfeKuZVb1=13SL-UUu5hkNE3Q3K8MTZA2ap1qDCAg@mail.gmail.com>
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
To: Thomas Renninger <trenn@suse.de>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Tue, Jan 8, 2013 at 8:50 AM, Thomas Renninger <trenn@suse.de> wrote:
> megaraid_sas

can you check if your initrd for kdump kernel has that driver and
module that it depends on like
scsi sas transport etc ?

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

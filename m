Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TsPUo-0000Hq-Hs
 for kexec@lists.infradead.org; Tue, 08 Jan 2013 03:04:59 +0000
Received: by mail-bk0-f50.google.com with SMTP id jf3so8927275bkc.37
 for <kexec@lists.infradead.org>; Mon, 07 Jan 2013 19:04:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3649945.08HKjS0y0c@hammer82.arch.suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1593084.QhbTkmoq3N@hammer82.arch.suse.de>
 <CAE9FiQWTiFu0+ymVroK84L-LCc7FBU1trdZAcaXqMGM2My6LzQ@mail.gmail.com>
 <3649945.08HKjS0y0c@hammer82.arch.suse.de>
Date: Mon, 7 Jan 2013 19:04:56 -0800
Message-ID: <CAE9FiQUueTB6gc5uMUApqeS7FtzMESLLFEt3ZuOMJgXsnjFQ0A@mail.gmail.com>
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

On Mon, Jan 7, 2013 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote:
> memmap=256M$3584M

may need to change to:

memmap=256M\$\$3584M

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWAEh-0002Bh-AL
 for kexec@lists.infradead.org; Wed, 07 Nov 2012 18:20:24 +0000
Received: by mail-bk0-f49.google.com with SMTP id j4so862403bkw.36
 for <kexec@lists.infradead.org>; Wed, 07 Nov 2012 10:20:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <509A044D.30100@jp.fujitsu.com>
References: <20121015065516.2832.42378.sendpatchset@indoh>
 <20121015065526.2832.90867.sendpatchset@indoh>
 <CAE9FiQXKjNU4Sasj4LmiFiNNu9quGgKAdW3ciVnXggoWZiYXJA@mail.gmail.com>
 <507CE14A.2020605@jp.fujitsu.com> <509A044D.30100@jp.fujitsu.com>
Date: Wed, 7 Nov 2012 10:20:20 -0800
Message-ID: <CAE9FiQWOfownBsSsw-36Ti-hHeKuVaq8Y5eaMHMHpLK4NXhC0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86, pci: Reset PCIe devices at boot time
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Tue, Nov 6, 2012 at 10:48 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
> I'm rewriting my reset code using your dummy pci_dev patch. Do you have
> a plan to post it or can I post it with my patches?

Yes, you can post it with your patches if you like.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

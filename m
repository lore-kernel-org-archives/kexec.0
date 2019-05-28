Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hVSBi-0003fW-G6
 for kexec@lists.infradead.org; Tue, 28 May 2019 02:50:08 +0000
Received: by mail-it1-f193.google.com with SMTP id 9so1667559itf.4
 for <kexec@lists.infradead.org>; Mon, 27 May 2019 19:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
 <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
 <20190521180855.GA7793@cz.tnic>
In-Reply-To: <20190521180855.GA7793@cz.tnic>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 28 May 2019 10:49:54 +0800
Message-ID: <CACPcB9fg5RGXcBbESNnn9rV0DSoh4jYkVWZrdcRWay5KKAjLww@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
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
To: Ingo Molnar <mingo@kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On Wed, May 22, 2019 at 2:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, May 21, 2019 at 05:02:59PM +0800, Kairui Song wrote:
> > Hi Boris, would you prefer to just fold Junichi update patch into the
> > previous one or I should send an updated patch?
>
> Please send a patch ontop after Ingo queues your old one, which should
> happen soon. This way it would also document the fact that there are
> machines with NVS regions only.
>
> Thx.
>

Hi, by now, I still didn't see any tip branch pick up this patch yet,
any update?

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

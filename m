Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTDnd-00069W-30
 for kexec@lists.infradead.org; Tue, 21 May 2019 23:04:02 +0000
Date: Wed, 22 May 2019 01:04:21 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190521230421.GA2435@cz.tnic>
References: <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514033338.GA6612@MiWiFi-R3L-srv>
 <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
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
To: Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Ingo Molnar <mingo@kernel.org>
Cc: fanc.fnst@cn.fujitsu.com, kasong@redhat.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>

On Tue, May 21, 2019 at 02:53:52PM -0700, Dirk van der Merwe wrote:
> Where can I find the next-merge-window tree?
> 
> I can test against that too.

It'll appear soon in a tip branch. I'd appreciate if you tested that
instead - stay tuned...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

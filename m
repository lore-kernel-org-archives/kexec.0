Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ7xN-00056Z-Mw
 for kexec@lists.infradead.org; Wed, 24 Apr 2019 02:48:23 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Date: Wed, 24 Apr 2019 02:47:32 +0000
Message-ID: <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
In-Reply-To: <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
Content-Language: ja-JP
Content-ID: <A0A18CB245553D4DBDDB1376DB3E1470@gisp.nec.co.jp>
MIME-Version: 1.0
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
To: Kairui Song <kasong@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 4/24/19 2:15 AM, Kairui Song wrote:
> On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>> Is the mapping of ACPI tables just by luck, too?
> 
> Good question, they should have same issue with systab, I ignored this one.
> Then in first kernel when doing kexec it should ensure both ACPI
> tables and the EFI systab are mapped, that should cover everything and
> make it work.

Right.

> Is there anything else missing?
No, as far as I looked around get_rsdp_addr().

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

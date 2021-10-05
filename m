Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgate.ics.forth.gr ([139.91.1.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXjKQ-00AJLi-DA
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 12:13:52 +0000
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
 by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id
 195CDaaj012087
 for <kexec@lists.infradead.org>; Tue, 5 Oct 2021 15:13:36 +0300 (EEST)
MIME-Version: 1.0
Date: Tue, 05 Oct 2021 15:13:30 +0300
From: Nick Kossifidis <mick@ics.forth.gr>
Subject: RISC-V: patched kexec-tools on github for review/testing
Message-ID: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, kexec@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, alex@ghiti.fr, rppt@kernel.org, geert+renesas@glider.be, Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, palmer@dabbelt.com, anup.patel@wdc.com, atish.patra@wdc.com

Hello all,

I've uploaded my kexec-tools patches for riscv on github for 
testing/review before sending them upstream.
https://github.com/riscv-collab/kexec-tools/tree/riscv

Both kexec and kdump were tested on latest rv64 qemu, using for-next 
branch with this patch applied:
https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/

Regards,
Nick

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

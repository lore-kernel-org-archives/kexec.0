Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hK0Uv-0003mV-AM
 for kexec@lists.infradead.org; Fri, 26 Apr 2019 13:02:38 +0000
Date: Fri, 26 Apr 2019 15:02:26 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
Message-ID: <20190426130226.GE4608@zn.tnic>
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com>
 <20190402103201.GF6826@zn.tnic>
 <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Fri, Apr 26, 2019 at 09:59:54AM +0800, lijiang wrote:
> Hope this help. Thanks.

It does help, yes. When this explanation above is part of the commit
message, it helps immensely!

:-)

> So sorry for the delay, i am trying my best to explain it in detail.

I don't care about the delay as long as the commit messages properly
explain why the change is needed.

So thanks for doing that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

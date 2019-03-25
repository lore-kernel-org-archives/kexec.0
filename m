Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8OWB-0007RE-Hk
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 12:15:57 +0000
Date: Mon, 25 Mar 2019 13:15:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190325121554.GJ12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
 <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
 <20190325064046.GB12016@zn.tnic>
 <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Mar 25, 2019 at 05:20:43PM +0800, lijiang wrote:
> Let's look at the discussion in patch v8, please refer to this link:
> https://lkml.org/lkml/2019/3/16/15
> 
> I did a test according to Tom's reply, and the test indicated his suggestion was
> correct, we should change this to check for IORES_DESC_ACPI_* values.

I know that discussion - I was on CC.

Your patch still doesn't explain *why* this change is needed and the
fact that you "did a test" and it worked doesn't answer my question a
single bit. In fact, it tells me that you have tried something at random
without even understanding why this is needed and makes me even more
suspicious towards what you're doing.

So slow down pls *think* why this change is needed and then *explain*
that in the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

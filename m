Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jldsL-0002sJ-4J
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 19:37:34 +0000
Date: Wed, 17 Jun 2020 12:37:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
Message-Id: <20200617123731.0dbb039a053a2ef610af59fb@linux-foundation.org>
In-Reply-To: <20200602045952.27487-1-lijiang@redhat.com>
References: <20200602045952.27487-1-lijiang@redhat.com>
Mime-Version: 1.0
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jbohac@suse.cz, bhe@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, dyoung@redhat.com

On Tue,  2 Jun 2020 12:59:52 +0800 Lianbo Jiang <lijiang@redhat.com> wrote:

> Signature verification is an important security feature, to protect
> system from being attacked with a kernel of unknown origin. Kexec
> rebooting is a way to replace the running kernel, hence need be
> secured carefully.

I'm finding this changelog quite hard to understand,

> In the current code of handling signature verification of kexec kernel,
> the logic is very twisted. It mixes signature verification, IMA signature
> appraising and kexec lockdown.
> 
> If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
> signature, the supported crypto, and key, we don't think this is wrong,

I think this is saying that in the absence of KEXEC_SIG_FORCE and if
the signature/crypto/key are all incorrect, the kexec still succeeds,
but it should not.

> Unless kexec lockdown is executed. IMA is considered as another kind of
> signature appraising method.
> 
> If kexec kernel image has signature/crypto/key, it has to go through the
> signature verification and pass. Otherwise it's seen as verification
> failure, and won't be loaded.

I don't know if this is describing the current situation or the
post-patch situation.

> Seems kexec kernel image with an unqualified signature is even worse than
> those w/o signature at all, this sounds very unreasonable. E.g. If people
> get a unsigned kernel to load, or a kernel signed with expired key, which
> one is more dangerous?
> 
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.

I think the whole thing needs a rewrite.  Start out by fully describing
the current situation.  THen describe what is wrong with it, and why. 
Then describe the proposed change.  Or something along these lines.

The changelog should also make clear the end-user impact of the patch. 
In sufficient detail for others to decide which kernel version(s)
should be patched.  Your recommendations will also be valuable - which
kernel version(s) do you think should be patched, and why?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

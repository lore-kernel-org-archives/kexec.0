Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XiwbB-0001Yk-7Z
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 02:33:29 +0000
Date: Tue, 28 Oct 2014 10:32:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V4] kernel, add bug_on_warn
Message-ID: <20141028023251.GD3329@darkstar.nay.redhat.com>
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <544E8985.50203@akamai.com> <544E8BB8.8000707@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <544E8BB8.8000707@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, isimatu.yasuaki@jp.fujitsu.com, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, Jason Baron <jbaron@akamai.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

> > Seems reasonable-I'm wondering why you just don't call panic() in this
> > case. The BUG() call at line '434' doesn't at anything since its just being
> > called from panic.c.
> 
> Hmm ... I didn't even think about that.
> 
> > 
> > So something like 'panic_on_warn' would seem to be more appropriate
> > in keeping with things like 'panic_on_oops' or 'panic_on_stackoverflow'.
> 
> I like it a lot better that way too :)  I'm changing it to panic_on_warn unless
> anyone has any strenuous objections.

I would vote for panic_on_warn, it will make more sense than bug_on_warn.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imap.thunk.org ([2600:3c02::f03c:91ff:fe96:be03])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z53zm-00034j-8W
 for kexec@lists.infradead.org; Wed, 17 Jun 2015 03:26:34 +0000
Date: Tue, 16 Jun 2015 23:26:07 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150617032607.GC4076@thunk.org>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
 <87zj3zigug.fsf@x220.int.ebiederm.org>
 <20150616202757.GB14943@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150616202757.GB14943@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Petr Tesarik <ptesarik@suse.cz>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>

On Tue, Jun 16, 2015 at 04:27:57PM -0400, Vivek Goyal wrote:
> 
> So looks like you are looking for a system/option where you just want to
> always make use of kexec_file_load() and disable kexec_load(). This sounds
> like you want a kernel where kexec_load() is compiled out and you want
> only kexec_file_load() in.

Either compiled out or disabled via some flag (similar to how signed
moduled verification can be required via a flag that can be set, but
not unset once it is set), yes.

> Right now one can't do that becase kexec_file_load() depends on
> CONFIG_KEXEC option.
> 
> I am wondering that how about making CONFIG_KEXEC_FILE_LOAD independent
> of CONFIG_KEXEC. That way one can set CONFIG_KEXEC_VERIFY_SIG=y, and
> only signed kernel can be kexeced on that system.

That would certianly also be a workable strategy.

> This should gel well with long term strategy of deprecating kexec_load()
> at some point of time when kexec_file_load() is ready to completely
> replace it.

Well, note that Debian and Ubuntu are still using kexec-tools 2.0.7
(even in their latest development/unstable releases), which doesn't
have support for kexec_file_load().  So we need to get Debian to
upgrade its kexec-tools as part of this.  I'll try to file a
nag-o-gram to the Debian BTS.

						- Ted

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

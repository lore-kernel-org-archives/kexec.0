Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUjfv-0007Jw-Fh
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 20:51:08 +0000
Date: Fri, 11 Oct 2013 21:50:16 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131011205016.GA5656@srcf.ucam.org>
References: <20131011154805.GB30181@srcf.ucam.org>
 <CAFLxGvzf1sQy-d03JAnK7eDQdBXrd-zRjcKEbv_x53st5bYELg@mail.gmail.com>
 <20131011163933.GA31941@srcf.ucam.org>
 <CAFLxGvyDYHy-UbZhdQiGvXL=8t0aW8wABc0GRkwVRy8egKJMKw@mail.gmail.com>
 <20131011164400.GA32133@srcf.ucam.org> <52582B97.2060907@nod.at>
 <20131011165542.GB32133@srcf.ucam.org> <52582E7D.8080909@nod.at>
 <20131011170138.GA32619@srcf.ucam.org>
 <87ob6va670.fsf@tw-ebiederman.twitter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ob6va670.fsf@tw-ebiederman.twitter.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: keir@xen.org, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, xen-devel@lists.xen.org, hbabu@us.ibm.com, david.vrabel@citrix.com, jbeulich@suse.com, "H. Peter Anvin" <hpa@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Oct 11, 2013 at 01:44:19PM -0700, Eric W. Biederman wrote:
> Matthew Garrett <mjg59@srcf.ucam.org> writes:
> > No, I manually look up some addresses from /proc/kallsyms and then 
> > modify them in the second kernel.
> 
> An interesting approach I think most of the rest of us would have just
> built a module, or rebuilt our kernels.

Well yeah, but my kernel refuses to load unsigned modules, so.

> Now if this is a backwards argument to remove that silly code path it
> totally fails because now we know the code has not bit-rotted and
> that there are active users.

No, it's not any argument of the kind.

> If you are still pushing the signed-boot agenda I eagerly await your
> patches to make all of this work in a sensible way with signed binaries.

Vivek's working on a separate kexec system call for that, as we agreed 
with Linus at LPC.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

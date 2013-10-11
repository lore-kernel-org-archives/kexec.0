Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUg0i-0000cf-7i
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 16:56:21 +0000
Date: Fri, 11 Oct 2013 17:55:42 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131011165542.GB32133@srcf.ucam.org>
References: <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
 <20131011125206.GA2772@redhat.com>
 <20131011153727.GA30181@srcf.ucam.org>
 <20131011154450.GB2772@redhat.com>
 <20131011154805.GB30181@srcf.ucam.org>
 <CAFLxGvzf1sQy-d03JAnK7eDQdBXrd-zRjcKEbv_x53st5bYELg@mail.gmail.com>
 <20131011163933.GA31941@srcf.ucam.org>
 <CAFLxGvyDYHy-UbZhdQiGvXL=8t0aW8wABc0GRkwVRy8egKJMKw@mail.gmail.com>
 <20131011164400.GA32133@srcf.ucam.org> <52582B97.2060907@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52582B97.2060907@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: keir@xen.org, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard.weinberger@gmail.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, xen-devel@lists.xen.org, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, jbeulich@suse.com, "H. Peter Anvin" <hpa@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>, david.vrabel@citrix.com

On Fri, Oct 11, 2013 at 06:47:19PM +0200, Richard Weinberger wrote:

> But you still need a magic tool which create you this list.

I just read /proc/kallsyms. I'm really not doing anything complicated.

> If you have a tool which takes two kernel images and create such
> a delta, fine.

Isn't that ksplice?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

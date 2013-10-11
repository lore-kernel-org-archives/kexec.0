Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUjcu-0007EJ-GN
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 20:48:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131011153727.GA30181@srcf.ucam.org>
 <20131011154450.GB2772@redhat.com>
 <20131011154805.GB30181@srcf.ucam.org>
 <CAFLxGvzf1sQy-d03JAnK7eDQdBXrd-zRjcKEbv_x53st5bYELg@mail.gmail.com>
 <20131011163933.GA31941@srcf.ucam.org>
 <CAFLxGvyDYHy-UbZhdQiGvXL=8t0aW8wABc0GRkwVRy8egKJMKw@mail.gmail.com>
 <20131011164400.GA32133@srcf.ucam.org> <52582B97.2060907@nod.at>
 <20131011165542.GB32133@srcf.ucam.org> <52582E7D.8080909@nod.at>
 <20131011170138.GA32619@srcf.ucam.org>
Date: Fri, 11 Oct 2013 13:44:19 -0700
In-Reply-To: <20131011170138.GA32619@srcf.ucam.org> (Matthew Garrett's message
 of "Fri, 11 Oct 2013 18:01:39 +0100")
Message-ID: <87ob6va670.fsf@tw-ebiederman.twitter.com>
MIME-Version: 1.0
Subject: Re: kexec: Clearing registers just before jumping into purgatory
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: keir@xen.org, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, xen-devel@lists.xen.org, hbabu@us.ibm.com, david.vrabel@citrix.com, jbeulich@suse.com, "H. Peter Anvin" <hpa@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> On Fri, Oct 11, 2013 at 06:59:41PM +0200, Richard Weinberger wrote:
>> Am 11.10.2013 18:55, schrieb Matthew Garrett:
>> > On Fri, Oct 11, 2013 at 06:47:19PM +0200, Richard Weinberger wrote:
>> > 
>> >> But you still need a magic tool which create you this list.
>> > 
>> > I just read /proc/kallsyms. I'm really not doing anything complicated.
>> > 
>> >> If you have a tool which takes two kernel images and create such
>> >> a delta, fine.
>> > 
>> > Isn't that ksplice?
>> 
>> So, you have a variant of ksplice which is able to kexec?
>
> No, I manually look up some addresses from /proc/kallsyms and then 
> modify them in the second kernel.

An interesting approach I think most of the rest of us would have just
built a module, or rebuilt our kernels.

Now if this is a backwards argument to remove that silly code path it
totally fails because now we know the code has not bit-rotted and
that there are active users.

If you are still pushing the signed-boot agenda I eagerly await your
patches to make all of this work in a sensible way with signed binaries.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

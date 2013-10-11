Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vc0-x229.google.com ([2607:f8b0:400c:c03::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUfeq-0008S3-JP
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 16:33:45 +0000
Received: by mail-vc0-f169.google.com with SMTP id ib11so3073867vcb.0
 for <kexec@lists.infradead.org>; Fri, 11 Oct 2013 09:33:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131011154805.GB30181@srcf.ucam.org>
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
 <877gdkce6s.fsf@tw-ebiederman.twitter.com>
 <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
 <20131011125206.GA2772@redhat.com>
 <20131011153727.GA30181@srcf.ucam.org>
 <20131011154450.GB2772@redhat.com>
 <20131011154805.GB30181@srcf.ucam.org>
Date: Fri, 11 Oct 2013 18:33:23 +0200
Message-ID: <CAFLxGvzf1sQy-d03JAnK7eDQdBXrd-zRjcKEbv_x53st5bYELg@mail.gmail.com>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Cc: keir@xen.org, Kees Cook <keescook@chromium.org>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, xen-devel@lists.xen.org, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, jbeulich@suse.com, "H. Peter Anvin" <hpa@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>, david.vrabel@citrix.com

On Fri, Oct 11, 2013 at 5:48 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, Oct 11, 2013 at 11:44:50AM -0400, Vivek Goyal wrote:
>
>> Just Curious. How is it useful. IOW, what's your use case of booting a new
>> kernel and then jumping back.
>
> I'm kexecing into a kernel with a modified /dev/mem, modifying the
> original kernel and then jumping back into it.

How do you update the original kernel?
Sounds interesting.

-- 
Thanks,
//richard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

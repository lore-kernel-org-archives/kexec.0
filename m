Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLkS4-0001Do-M5
 for kexec@lists.infradead.org; Thu, 12 Feb 2015 03:28:32 +0000
Date: Thu, 12 Feb 2015 11:29:18 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] multiboot: fix crash on NULL kernel command line
Message-ID: <20150212032918.GE6861@dhcp-128-1.nay.redhat.com>
References: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
 <CAFAJAEz_z0mvGih2iJ8hDuPNh9OL+18k2_tbjsF7=ydceUG9DQ@mail.gmail.com>
 <CAFAJAEwUkEnJgPr30-+KhGMQKss0C1mcEC8wm4+KYiVqXbKsGw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFAJAEwUkEnJgPr30-+KhGMQKss0C1mcEC8wm4+KYiVqXbKsGw@mail.gmail.com>
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
To: Ameya Palande <2ameya@gmail.com>
Cc: kexec@lists.infradead.org

On 02/11/15 at 09:22am, Ameya Palande wrote:
> On Tue, Feb 10, 2015 at 8:00 AM, Ameya Palande <2ameya@gmail.com> wrote:
> > On Thu, Feb 5, 2015 at 1:36 PM, Ameya Palande <2ameya@gmail.com> wrote:
> >> If "--command-line" option is not specified, then kexec segfaults while
> >> dereferencing NULL command line string pointer. While we are at it, also
> >> fix indentation and use '{' and '}' consistently.
> >>
> >> Signed-off-by: Ameya Palande <2ameya@gmail.com>
> >
> > Any update on this one?
> 
> Is there anything wrong with this patch? Is this the correct mailing
> list for exec-tools related patch?
> 
> Cheers,
> Ameya.

As Simon's comment in this thread, you should split up your patch to
separate the fix and cleanup to be reviewed clearly.

Thanks
Minfei

> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

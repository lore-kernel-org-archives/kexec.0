Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGev-0002w8-5p
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 20:12:34 +0000
Date: Wed, 21 Nov 2012 15:12:29 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
Message-ID: <20121121201229.GJ13114@redhat.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121145023.GD13114@redhat.com>
 <CAE9FiQUHapB8_uGwMtM84xOHpMvWmVbn2Z8h0C=n_rfHPCbY_g@mail.gmail.com>
 <20121121200059.GH13114@redhat.com>
 <CAE9FiQWMo1mxNyk=co9rL3ST0GTCjniVJQKUNyT8_6MrbYNJHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQWMo1mxNyk=co9rL3ST0GTCjniVJQKUNyT8_6MrbYNJHQ@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Nov 21, 2012 at 12:09:04PM -0800, Yinghai Lu wrote:
> On Wed, Nov 21, 2012 at 12:00 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Wed, Nov 21, 2012 at 11:50:56AM -0800, Yinghai Lu wrote:
> >
> > [..]
> >> > So how do I force a 16bit or 32bit entry using a bzImage64?
> >>
> >> kexec -t bzImage -l ....
> >> will load low and use 32bit entry.
> >>
> >
> > Ok, so user needs to enforce image type (using -t option) to bzImage
> > (for a bzImage which supports 64bit entry point) to be able to use
> > 32bit entry.
> >
> > I think a better option is that bzImage64 loader parses the user specified
> > entry options and call into 32bit bzImage loader if user is asking for 32bit
> > or 16bit entry. For 16bit, we already have option --real-mode option. May
> > be we need to introduce another one for forcing 32bit entry, say --entry-32bit
> > or --protected-mode (whatever makes sense).
> 
> that is doable.
> 
> add checking entry-32bit and real-mode checking in kexec-bzImage64.c
> and bail early to leave kexec-bzImage.c to take over.

Or actually can we do reverse. Do not introduce new image format
bzImage64. In existing bzImage loader if bzImage version is greater
than 0x020c (or whatever version has 64bit entry extension), just
call into load_bzImage64().

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

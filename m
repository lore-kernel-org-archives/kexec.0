Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtprelay.restena.lu ([2001:a18:1::62])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIlpN-0007Hg-4W
 for kexec@lists.infradead.org; Sun, 08 Sep 2013 20:43:26 +0000
Date: Sun, 8 Sep 2013 22:42:49 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 1/3] kexec: get rid of late printk
Message-ID: <20130908224249.61a866ed@neptune.home>
In-Reply-To: <CAKMK7uHa+uNAW-d=Tj5d27dkCqhZ0EJqyPThW3tK13bnVTbzjw@mail.gmail.com>
References: <20130908120947.GA360@x4> <20130908121027.GB360@x4>
 <CAKMK7uHa+uNAW-d=Tj5d27dkCqhZ0EJqyPThW3tK13bnVTbzjw@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Markus Trippelsdorf <markus@trippelsdorf.de>

On Sun, 08 September 2013 Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sun, Sep 8, 2013 at 2:10 PM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> > kexec calls:
> >  printk(KERN_EMERG "Starting new kernel\n");
> > late before calling machine_shutdown().
> > However at this point the underlying fb device may have already been
> > shutdown. This causes the kernel to hang.
> > Fix by simply getting rid of the printk call.
> >
> > Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> 
> Shouldn't this be taken care of with the suspend/resume_console calls?
> At least that's my understanding how it works in the suspend/hibernate
> code, maybe kexec needs similar treatment ...

Is it suspend/resume_console? Shouldn't the fbcon be short-circuited
or disabled once there is no more underlying fb?
Serial console, if present, as well as netconsole if network device
is still alive should continue working I would say.

Bruno

> -Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

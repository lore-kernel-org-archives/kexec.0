Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x235.google.com ([2607:f8b0:4001:c03::235])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIlL8-000710-Tz
 for kexec@lists.infradead.org; Sun, 08 Sep 2013 20:12:12 +0000
Received: by mail-ie0-f181.google.com with SMTP id y16so5945499ieg.12
 for <kexec@lists.infradead.org>; Sun, 08 Sep 2013 13:11:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130908121027.GB360@x4>
References: <20130908120947.GA360@x4>
	<20130908121027.GB360@x4>
Date: Sun, 8 Sep 2013 22:11:40 +0200
Message-ID: <CAKMK7uHa+uNAW-d=Tj5d27dkCqhZ0EJqyPThW3tK13bnVTbzjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kexec: get rid of late printk
From: Daniel Vetter <daniel@ffwll.ch>
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
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, dri-devel <dri-devel@lists.freedesktop.org>

On Sun, Sep 8, 2013 at 2:10 PM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> kexec calls:
>  printk(KERN_EMERG "Starting new kernel\n");
> late before calling machine_shutdown().
> However at this point the underlying fb device may have already been
> shutdown. This causes the kernel to hang.
> Fix by simply getting rid of the printk call.
>
> Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>

Shouldn't this be taken care of with the suspend/resume_console calls?
At least that's my understanding how it works in the suspend/hibernate
code, maybe kexec needs similar treatment ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

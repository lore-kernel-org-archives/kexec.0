Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3QXz-0000YP-8C
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 17:16:12 +0000
Received: by mail-qt0-x232.google.com with SMTP id g60so6297958qtd.3
 for <kexec@lists.infradead.org>; Wed, 26 Apr 2017 10:15:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <125ffde4-2103-48b5-2c46-886436619124@redhat.com>
References: <CAKDfjgcvs=OQrBSXB=u9uYgo6y0vOE62+XmhObqON0z9TR3DoQ@mail.gmail.com>
 <125ffde4-2103-48b5-2c46-886436619124@redhat.com>
From: Kristian Kielhofner <kris@kriskinc.com>
Date: Wed, 26 Apr 2017 12:15:26 -0500
Message-ID: <CAKDfjgeo_DNqi6=rDA6nPtjSsSOWGJXA7piQ_LL8yxqUOyg9Jg@mail.gmail.com>
Subject: Re: Kexec on ARM - memory detection
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Apr 21, 2017 at 6:27 AM, Pratyush Anand <panand@redhat.com> wrote:
> Hi Kristian,
>
> Sorry, I missed this mail.
> Are you still on it, or it is solved?

  No problem, I'm still experiencing the issue but I haven't
investigated it further.

>
>
> How does kexec-tools see above memory ranges?
> As per your /proc/iomem, it should have been
> 42000000-5fffffff (0)
>
> Can you put some extra debug print in your code and check why do you have
> above behavior?
>

  Can you point towards some examples or documentation for what you're
looking for?

Thanks for your help!

-- 
Kristian Kielhofner

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

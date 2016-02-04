Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRTjg-00005Q-2O
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 23:54:52 +0000
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 5 Feb 2016 09:54:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 214622BB005B
 for <kexec@lists.infradead.org>; Fri,  5 Feb 2016 10:54:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u14NsIfC48103606
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 10:54:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u14Nrrdt019240
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 10:53:54 +1100
Message-ID: <1454630013.2648.12.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3.1] firmware: clean up filesystem load exit path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 04 Feb 2016 18:53:33 -0500
In-Reply-To: <20160204220122.GL12481@wotan.suse.de>
References: <20160204211501.GA14755@www.outflux.net>
 <20160204220122.GL12481@wotan.suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-security-module@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Josh Boyer <jwboyer@fedoraproject.org>, Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-04 at 23:01 +0100, Luis R. Rodriguez wrote:
> On Thu, Feb 04, 2016 at 01:15:02PM -0800, Kees Cook wrote:
> > This makes the error and success paths more readable while trying to
> > load firmware from the filesystem.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Cc: Josh Boyer <jwboyer@fedoraproject.org>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Thanks,
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> > ---
> > Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"
> 
> Mimi, feel free to pick up as a replacement in your series.

Ok, thanks!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMLiW-0007cX-Ur
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 20:20:32 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 06:20:05 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AD7052BB0054
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:19:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LKJPiO50331896
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:19:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LKJNri010411
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:19:24 +1100
Message-ID: <1453407534.9549.154.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 00/11] vfss: support for a common kernel file loader
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 15:18:54 -0500
In-Reply-To: <20160121201653.GD20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121201653.GD20964@wotan.suse.de>
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
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-01-21 at 21:16 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:15AM -0500, Mimi Zohar wrote:
> >
> > The latest version of these patches can be found in the next-kernel-read-v2
> > branch of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > 
> > [1] Taken from Luis Rodriguez's wiki -
> > http://kernelnewbies.org/KernelProjects/common-kernel-loader
> 
> Did 0-day bot get a chance to test this tree? If not can it
> be added ?

Yes, I get the notifications.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

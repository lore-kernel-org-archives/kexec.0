Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aME0E-0003b5-9S
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 12:06:15 +0000
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 22:05:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 992953578056
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:05:46 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LC5cw746203044
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:05:46 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LC5D0b017351
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:05:14 +1100
Message-ID: <1453377894.9549.83.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 07/11] firmware: replace call to
 fw_read_file_contents() with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 07:04:54 -0500
In-Reply-To: <CAGXu5jLgkh5iNCW1nLR3o8omS4YH2o-SkL2AQK26W94hJ9UbHg@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAGXu5jLgkh5iNCW1nLR3o8omS4YH2o-SkL2AQK26W94hJ9UbHg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: "linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R.
 Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Tue, 2016-01-19 at 16:10 -0800, Kees Cook wrote:
> On Mon, Jan 18, 2016 at 7:11 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Replace fw_read_file_contents() for reading a file with the common VFS
> > kernel_read_file() function.  A benefit of calling kernel_read_file()
> > to read the firmware is the firmware is read only once, instead of once
> > for measuring/appraising the firmware and again for reading the file
> > contents into memory.
> >
> > This patch retains the kernel_fw_from_file() hook, which is called from
> > security_kernel_post_read_file(), but removes the
> > sercurity_kernel_fw_from_file() function.
> >
> > Changelog:
> > - reordered and squashed firmware patches
> > - fix MAX firmware size (Kees Cook)
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

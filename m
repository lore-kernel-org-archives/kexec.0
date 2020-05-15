Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZhtg-0001kK-6B
 for kexec@lists.infradead.org; Fri, 15 May 2020 21:29:38 +0000
Received: by mail-pj1-f66.google.com with SMTP id n15so1560531pjt.4
 for <kexec@lists.infradead.org>; Fri, 15 May 2020 14:29:35 -0700 (PDT)
Date: Fri, 15 May 2020 21:29:33 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200515212933.GD11244@42.do-not-panic.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513181736.GA24342@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: rafael@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> Can you also move kernel_read_* out of fs.h?  That header gets pulled
> in just about everywhere and doesn't really need function not related
> to the general fs interface.

Sure, where should I dump these?

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

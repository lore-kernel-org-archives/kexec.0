Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sun, 17 May 2020 23:22:55 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200518062255.GB15641@infradead.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515212933.GD11244@42.do-not-panic.com>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > Can you also move kernel_read_* out of fs.h?  That header gets pulled
> > in just about everywhere and doesn't really need function not related
> > to the general fs interface.
> 
> Sure, where should I dump these?

Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
of the file comment explaining the point of the interface, which I
still don't get :)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

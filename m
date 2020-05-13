Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 13 May 2020 11:17:36 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200513181736.GA24342@infradead.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
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
Cc: rafael@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

Can you also move kernel_read_* out of fs.h?  That header gets pulled
in just about everywhere and doesn't really need function not related
to the general fs interface.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

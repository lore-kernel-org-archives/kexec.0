Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRQ0t-0000BW-Pb
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 19:56:24 +0000
Date: Thu, 4 Feb 2016 20:56:01 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 16/22] module: replace copy_module_from_fd with kernel
 version
Message-ID: <20160204195601.GF12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-17-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1454526390-19792-17-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 03, 2016 at 02:06:24PM -0500, Mimi Zohar wrote:
> Replace copy_module_from_fd() with kernel_read_file_from_fd().
> 
> Although none of the upstreamed LSMs define a kernel_module_from_file
> hook, IMA is called, based on policy, to prevent unsigned kernel modules
> from being loaded by the original kernel module syscall and to
> measure/appraise signed kernel modules.
> 
> The security function security_kernel_module_from_file() was called prior
> to reading a kernel module.  Preventing unsigned kernel modules from being
> loaded by the original kernel module syscall remains on the pre-read
> kernel_read_file() security hook.  Instead of reading the kernel module
> twice, once for measuring/appraising and again for loading the kernel
> module, the signature validation is moved to the kernel_post_read_file()
> security hook.
> 
> This patch removes the security_kernel_module_from_file() hook and security
> call.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

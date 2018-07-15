Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1feWok-0002rJ-3C
 for kexec@lists.infradead.org; Sun, 15 Jul 2018 02:31:23 +0000
Received: by mail-yw0-f194.google.com with SMTP id y203-v6so13105352ywd.9
 for <kexec@lists.infradead.org>; Sat, 14 Jul 2018 19:31:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:30:10 -0700
Message-ID: <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] module: replace the existing LSM hook in
 init_module
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-security-module <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Both the init_module and finit_module syscalls call either directly
> or indirectly the security_kernel_read_file LSM hook.  This patch
> replaces the direct call in init_module with a call to the new
> security_kernel_load_data hook and makes the corresponding changes
> in SELinux, LoadPin, and IMA.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

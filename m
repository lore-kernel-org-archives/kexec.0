Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1feWYp-0004Xs-MN
 for kexec@lists.infradead.org; Sun, 15 Jul 2018 02:15:00 +0000
Received: by mail-yw0-f195.google.com with SMTP id 139-v6so13085384ywg.12
 for <kexec@lists.infradead.org>; Sat, 14 Jul 2018 19:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1531505163-20227-2-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:13:39 -0700
Message-ID: <CAGXu5jKU-cdYCQePZAr_eEUEsaK92kABFF=UowhaO6yuWVXEVA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] security: define new LSM hook named
 security_kernel_load_data
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-security-module <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Differentiate between the kernel reading a file specified by userspace
> from the kernel loading a buffer containing data provided by userspace.
> This patch defines a new LSM hook named security_kernel_load_data().
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1feWn6-0001W3-1j
 for kexec@lists.infradead.org; Sun, 15 Jul 2018 02:29:41 +0000
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so13089622ywm.11
 for <kexec@lists.infradead.org>; Sat, 14 Jul 2018 19:29:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 14 Jul 2018 19:28:28 -0700
Message-ID: <CAGXu5jL8_nbUKKNO-PCyGwOdQ+vjPZ7_17FKNH1fssgtfjk=Rw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] ima: add build time policy
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-security-module <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> IMA by default does not measure, appraise or audit files, but can be
> enabled at runtime by specifying a builtin policy on the boot command line
> or by loading a custom policy.
>
> This patch defines a build time policy, which verifies kernel modules,
> firmware, kexec image, and/or the IMA policy signatures.  This build time
> policy is automatically enabled at runtime and persists after loading a
> custom policy.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

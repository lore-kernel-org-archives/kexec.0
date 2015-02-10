Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x22e.google.com ([2607:f8b0:4003:c01::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLDF3-0003J9-Vt
 for kexec@lists.infradead.org; Tue, 10 Feb 2015 16:00:53 +0000
Received: by mail-ob0-f174.google.com with SMTP id wo20so32237701obc.5
 for <kexec@lists.infradead.org>; Tue, 10 Feb 2015 08:00:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
References: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
Date: Tue, 10 Feb 2015 08:00:28 -0800
Message-ID: <CAFAJAEz_z0mvGih2iJ8hDuPNh9OL+18k2_tbjsF7=ydceUG9DQ@mail.gmail.com>
Subject: Re: [PATCH] multiboot: fix crash on NULL kernel command line
From: Ameya Palande <2ameya@gmail.com>
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
To: kexec@lists.infradead.org

On Thu, Feb 5, 2015 at 1:36 PM, Ameya Palande <2ameya@gmail.com> wrote:
> If "--command-line" option is not specified, then kexec segfaults while
> dereferencing NULL command line string pointer. While we are at it, also
> fix indentation and use '{' and '}' consistently.
>
> Signed-off-by: Ameya Palande <2ameya@gmail.com>

Any update on this one?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

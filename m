Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baDCp-0006y0-6q
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 02:37:20 +0000
Message-ID: <1471487809.4319.15.camel@perches.com>
Subject: Re: [PATCH v8 1/2] Documentation: kdump: remind user of nr_cpus
From: Joe Perches <joe@perches.com>
Date: Wed, 17 Aug 2016 19:36:49 -0700
In-Reply-To: <1471487495-22787-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1471487495-22787-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471487495-22787-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, xlpang@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

On Thu, 2016-08-18 at 10:31 +0800, Zhou Wenjian wrote:
> nr_cpus can help to save memory. So we should remind user of it.

trivia:
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
[]
> @@ -390,9 +390,11 @@ Notes on loading the dump-capture kernel:
> =A0* Boot parameter "1" boots the dump-capture kernel into single-user
> =A0=A0=A0mode without networking. If you want networking, use "3".
> =A0
> -* We generally don' have to bring up a SMP kernel just to capture the
> +* We generally don' have to bring up an SMP kernel just to capture the

don't or do not


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

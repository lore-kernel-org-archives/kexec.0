Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-we0-f171.google.com ([74.125.82.171])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WDsfI-0008Bv-Vj
 for kexec@lists.infradead.org; Thu, 13 Feb 2014 09:33:06 +0000
Received: by mail-we0-f171.google.com with SMTP id u56so7249124wes.30
 for <kexec@lists.infradead.org>; Thu, 13 Feb 2014 01:32:40 -0800 (PST)
Message-ID: <52FC8FB8.5030702@canonical.com>
Date: Thu, 13 Feb 2014 10:26:16 +0100
From: Louis Bouchard <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: Tool for creating full vmcore
References: <52FBD7C3.4060304@acm.org>
In-Reply-To: <52FBD7C3.4060304@acm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: minyard@acm.org, kexec@lists.infradead.org

Hello,

Le 12/02/2014 21:21, Corey Minyard a =E9crit :
> Hello,
> =

> I've written a tool that takes an coredump of physical kernel memory and
> converts it to a coredump of virtual kernel memory that can be directly
> used by gdb to debug a kernel.
> =

> I was trying to use /proc/vmcore, but that did not include any of
> vmalloc memory or vmemmap, which made it kind of useless.  I thought
> about adding all that to the vmcore, but that didn't seem like the
> proper way to do things.
> =

> The tool is at https://github.com/cminyard/kdump-tool

Aside from the other opinions already expressed, I think that the name coll=
ision
is unfortunate and will cause problems.

kdump-tools is all over Debian and Ubuntu. I would suggest to rename your
project to something else.

Kind regards,

...Louis

-- =

Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu support: http://canonical.com/support

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

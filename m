Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ey-out-1920.google.com ([74.125.78.148])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDbgv-0001iC-Jv
	for kexec@lists.infradead.org; Thu, 26 Nov 2009 10:35:18 +0000
Received: by ey-out-1920.google.com with SMTP id 4so136349eyg.26
	for <kexec@lists.infradead.org>; Thu, 26 Nov 2009 02:35:12 -0800 (PST)
From: Yuri Bushmelev <jay4mail@gmail.com>
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it *libc
	agnostic. Tested against klibc and dietlibc.
Date: Thu, 26 Nov 2009 13:34:10 +0300
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<4B0DBFA4.7090009@bwalle.de> <20091126001410.GA853@verge.net.au>
In-Reply-To: <20091126001410.GA853@verge.net.au>
MIME-Version: 1.0
Message-Id: <200911261334.10310.jay4mail@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Bernhard Walle <bernhard@bwalle.de>, kexec@lists.infradead.org, Andrea Adami <andrea.adami@gmail.com>

Hello!
> On Thu, Nov 26, 2009 at 12:37:08AM +0100, Bernhard Walle wrote:
> > Simon Horman schrieb:
> > > +
> > > +	if ( NULL == p)
> > > +		return -1;
> >
> > Wouldn't that be better 'p == NULL'?
> 
> Agreed

That is form of 'early bug detection' of mistyped '=='.
E.g. you can write by mistype
	if (p = NULL) {}
but can't
	if (NULL = p) {}
because you will get compiler error.

-- 
Yuri Bushmelev

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

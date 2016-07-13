Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJpT-0006Zm-O3
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 13:03:56 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1468399874-5880-1-git-send-email-jia.zhang@windriver.com>
References: <1468399874-5880-1-git-send-email-jia.zhang@windriver.com>
Subject: Re: [PATCH 1/2] PKCS#7: Fix kernel panic when referring to the empty
 AuthorityKeyIdentifier
MIME-Version: 1.0
Content-ID: <4079.1468415011.1@warthog.procyon.org.uk>
Date: Wed, 13 Jul 2016 14:03:31 +0100
Message-ID: <4080.1468415011@warthog.procyon.org.uk>
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
To: Lans Zhang <jia.zhang@windriver.com>
Cc: dhowells@redhat.com, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com

Lans Zhang <jia.zhang@windriver.com> wrote:

> -		} else {
> -			auth = sig->auth_ids[1];
> +		} else if ((auth = sig->auth_ids[1])) {

Better to say:

	} else if (auth) {
		auth = sig->auth_ids[1];

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

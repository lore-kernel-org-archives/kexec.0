Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eeGZf-0004W5-Ok
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 08:38:29 +0000
Date: Wed, 24 Jan 2018 09:37:59 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20180124083759.qaiuhgpzcd3uiosz@verge.net.au>
References: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
 <20180118075344.i4dwybgdlpnmomkc@verge.net.au>
 <ef4e3c0e-e648-20d5-ef9f-51b2ba01740d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef4e3c0e-e648-20d5-ef9f-51b2ba01740d@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Tue, Jan 23, 2018 at 12:02:34PM -0600, Eric DeVolder wrote:
> Simon,
> Thank you! I've a request below.

Understood. As a rule I think its better not to update the git commits.
But I think the risk of fallout is low here so I've updated the changelog
as best I can.

Please take a look at the updated commit which has id
894bea9335f57b62cbded7b02ab7d58308b647d8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

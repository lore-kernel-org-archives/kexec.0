Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee2u7-0002bC-RM
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 18:02:41 +0000
Subject: Re: [PATCH v4] kexec-tools: Perform run-time linking of libxenctrl.so
References: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
 <20180118075344.i4dwybgdlpnmomkc@verge.net.au>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <ef4e3c0e-e648-20d5-ef9f-51b2ba01740d@oracle.com>
Date: Tue, 23 Jan 2018 12:02:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180118075344.i4dwybgdlpnmomkc@verge.net.au>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, kexec@lists.infradead.org, konrad.wilk@oracle.com

Simon,
Thank you! I've a request below.
Eric

On 01/18/2018 01:53 AM, Simon Horman wrote:
> On Wed, Jan 17, 2018 at 10:39:01AM -0600, Eric DeVolder wrote:
>> When kexec is utilized in a Xen environment, it has an explicit
>> run-time dependency on libxenctrl.so. This dependency occurs
>> during the configure stage and when building kexec-tools.
> 
> ...
> 
> Thanks for addressing this and thanks doubly for the very comprehensive
> changelog.
> 
> Applied.
> 

In the commit message, I show this post-patch results table:

The results were:

  Scenario | Xen environment   | non-Xen environment
  1        | fail - see Note 5 | pass
  2        | fail - see Note 5 | pass
  3        | fail - see Note 6 | pass
  4        | pass              | pass
  5        | fail - see Note 6 | pass
  6        | pass              | pass

There is an error here in what I reported, the table should in fact
report a fail for scenario 4 in the non-Xen environment.

If it isn't too late, I think it would be worthwhile to reword
the commit message for these corrections:

238c238
<  4        | pass              | pass
---
 >  4        | pass              | fail - see Note 7
249a250,254
 > Note 7: This kexec has the explicit dependency on libxenctrl.so
 > which prevents it from running in a non-Xen environment. This is
 > expected as this is the original issue for which this patch is
 > intended to address.
 >
253c258
< libxenctrl.so, all six scenarios are expected to "pass" in a
---
 > libxenctrl.so, all but scenario 4 are expected to "pass" in a


Regards,
Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

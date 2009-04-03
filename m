Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=TX2EHSOBE006.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LpYqM-0001BL-3T
	for kexec@lists.infradead.org; Fri, 03 Apr 2009 02:09:24 +0000
Message-ID: <49D56FB1.4070605@am.sony.com>
Date: Thu, 2 Apr 2009 19:08:49 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [Cbe-oss-dev] kexec trouble with gcc-4.3
References: <49D506BB.9030409@am.sony.com> <1238717065.6227.5.camel@localhost>
In-Reply-To: <1238717065.6227.5.camel@localhost>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: michael@ellerman.id.au
Cc: kexec@lists.infradead.org, cbe-oss-dev@ozlabs.org

On 04/02/2009 05:04 PM, Michael Ellerman wrote:
> On Thu, 2009-04-02 at 11:40 -0700, Geoff Levand wrote:
>> Hi,
>> 
>> I tried building kexec with gcc-4.3 from the cell sdk-3.1
>> and the resulting binary didn't work correctly.  It works
>> OK with the gcc-4.1 from the same (sdk-3.1).
> 
> You mean building kexec-tools? Or building the kernel?

The kexec program in kexec-tools.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

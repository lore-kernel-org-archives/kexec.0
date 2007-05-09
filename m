Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound1-dub-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hlait-00054p-IW
	for kexec@lists.infradead.org; Tue, 08 May 2007 21:12:09 -0400
Message-ID: <46411FDC.7040506@am.sony.com>
Date: Tue, 08 May 2007 18:11:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [patch 1/5] kexec debug output improvments
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
	<20070508062019.GC5400@in.ibm.com> <46408AFD.10107@am.sony.com>
	<20070508160222.GA32159@in.ibm.com>
In-Reply-To: <20070508160222.GA32159@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org

Vivek Goyal wrote:
> On Tue, May 08, 2007 at 07:36:45AM -0700, Geoff Levand wrote:
>> Vivek Goyal wrote:
>> > On Mon, May 07, 2007 at 05:02:47PM -0700, Geoff Levand wrote:
>> >> +#define dprintf(args...) dfprintf(stdout, args)
>> >>  #ifdef DEBUG
>> >> -#define dfprintf(args...)	do {fprintf(args);} while(0)
>> >> +#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
>> > 
>> > Should't dprintf() also be inside #ifdef DEBUG?
>> 
>> Then you need two identical defs for dprintf.
>> 
> 
> Nope. 
> 
> This is a debug print and should be enabled only if DEBUG is defined.

I have that, but you cut that part of the patch which shows it
from your reply.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

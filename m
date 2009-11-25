Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f187.google.com ([209.85.211.187])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDACU-0003WI-TQ
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 05:14:03 +0000
Received: by ywh17 with SMTP id 17so7099469ywh.2
	for <kexec@lists.infradead.org>; Tue, 24 Nov 2009 21:13:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
References: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
Date: Wed, 25 Nov 2009 14:13:56 +0900
Message-ID: <aec7e5c30911242113y7706e9c0u2262cdd7ab8bf38d@mail.gmail.com>
Subject: Re: Architecture detection code
From: Magnus Damm <magnus.damm@gmail.com>
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
To: Marc Andre Tanner <mat@brain-dump.org>
Cc: damm@opensource.se, horms@verge.net.au, kexec@lists.infradead.org

On Sat, Nov 21, 2009 at 2:38 AM, Marc Andre Tanner <mat@brain-dump.org> wrote:
> I recently had the same problem as Magnus and came up with the
> following patch. It changes the architecture detection code to
> also accept partiall matches. Which means and "arm" entry in
> arch_map_entry will work for all arm* versions.
>
> Please consider applying this patch and reverting the two from
> Magnus.

Sure, I'm happy to see that the arm supports gets more attention! =)

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

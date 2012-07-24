Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout-de.gmx.net ([213.165.64.23])
 by merlin.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
 id 1StjFK-00045z-EK
 for kexec@lists.infradead.org; Tue, 24 Jul 2012 17:50:43 +0000
Message-ID: <500EE046.2000705@gmx.at>
Date: Tue, 24 Jul 2012 19:49:58 +0200
From: =?ISO-8859-15?Q?Christian_Schaubschl=E4ger?=
 <christian.schaubschlaeger@gmx.at>
MIME-Version: 1.0
Subject: Problem with kexec on i386, linux-3.5
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello list,

I'm not sure if this is the correct place to post this; if it's not, I'd like to apologize.

Here's a short description of my problem:

I have a tiny protected-/real mode program, which I start using kexec (kexec-tools 2.0.3 released 05 April 2012). At some point this program makes a call to extended-int13 to read data from the disk. Now starting with linux-3.5-rc1 (and at least up to linux-3.5) this extended int13 call does not work any more. Apparently the call returns with error code 0x80, which means "timeout (not ready)".

I have two machines here, both with Intel chipsets (one CougarPoint, one older ICH7-M), and I see the same behaviour on both machines.

When I use older kernels (starting from 2.6.something up to 3.4.6), everything works fine.

Now I'm not sure if this is a kernel issue, or a kexec issue, or a mistake by myself. Maybe someone has a hint for me...

If required, of course, I can provide more detailed information about my hardware, kernel config, etc. (since I'm not sure if this is the correct place, I wanted to keep this message short for now).

Thank you
Christian Schaubschlaeger




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

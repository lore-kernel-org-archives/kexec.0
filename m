Return-path: <kexec-bounces@lists.infradead.org>
Received: from [67.15.197.40] (helo=web2mail.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ickih-0007U5-SS
	for kexec@lists.infradead.org; Tue, 02 Oct 2007 17:35:44 +0100
Subject: using bios after linux
From: msundius@u1.netgate.com
Message-Id: <20071002161238.25C524700E1@web2mail.com>
Date: Tue,  2 Oct 2007 16:12:38 +0000 (GMT)
Reply-To: msundius@u1.netgate.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: vygoyal@in.ibm.com
Cc: kexec@lists.infradead.org

--------------------------------------------------
Here is a message for you from http://web2mail.com
The easy way to read and send POP email on the web
--------------------------------------------------

Vivek,



Thank you for your reply.



I can't really say what our application is, as I'm a contractor and paid to keep my mouth shut.



As for the question of kexec as a library. yes it would be easier for me,

but we are not always paid to do the easy thing. My client 

wants to be sure that it is difficult for others to find the payload of

kexec. that means not writing it to a file. I also think that enough

applications will eventually exist out there that want to restart 

the OS that a library call is warrented.



Other questions:.. what happened to lists.infradead.org? seems to have been 

vaporized. 



more importantly, yes, I've read in the archives that Eric gave up on 

calling bios after linux. Was this because linux stomped on the state of 

bios, or that linux (its drivers really) leaves the physical hardware 

(devices) in such an undeterminate state such that  bios cannot handle 

the sudden change or complicated confiuration. 



Before you answer, that last one, I realize that it is largely symantic, 

but what I mean is that is this more of a problem inherent in how some

bios' are not well behaved and should be fixed or is it that linux does

not close down nicely and therefore should be fixed? we will never 

shutdown as in the case of a crash dump, but rather do our best to clean

up after ourselves. 



Thus, we probably don't have a problem fixing a bug or two to make that happen

so bios runs.  on the other hand the decision makers want to avoid having

a whole army of people fixing drivers to make them turn off correctly.



(or better, am I on a fools errend or should I keep up the fight?)



well, thanks for your input. 



Mike



ps sorry for not quoting the original email, I'm not on my normal computer

and am writing from web2mail :[



 





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

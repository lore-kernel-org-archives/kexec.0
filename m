Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kazeon.com ([209.172.74.40] helo=bigfoot.kazeon.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HnjqV-0001fp-In
	for kexec@lists.infradead.org; Mon, 14 May 2007 19:20:53 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: kexec and kdb
Date: Mon, 14 May 2007 16:20:29 -0700
Message-ID: <4E022DDAB8F45741914ACD6EDFE2309B041EB5E9@BIGFOOT.kazeon.local>
In-Reply-To: <20070511042300.GA16944@in.ibm.com>
From: "Preetesh Parekh" <preetesh@kazeon.com>
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

Hi Vivek,

I did modify "arch/i386/kernel/traps.c" file at 2 places as per your
suggestion but still problem is not solved. Please let us know.

File content of traps.c in function __kprobes die_nmi:
        show_registers(regs);
#ifdef  CONFIG_KDB
        kdb(KDB_REASON_NMI, 0, regs);
#endif  /* CONFIG_KDB */
        console_silent();        spin_unlock(&nmi_print_lock);
        bust_spinlocks(0);

        /* If we are in kernel we are probably nested up pretty bad
         * and might aswell get out now while we still can.
        */
        if (!user_mode_vm(regs)) {
                current->thread.trap_no = 2;
                crash_kexec(regs);
        }


File content of traps.c in function die:
        bust_spinlocks(0);
        die.lock_owner = -1;
        spin_unlock_irqrestore(&die.lock, flags);
#ifdef  CONFIG_KDB
        kdb_diemsg = str;
        kdb(KDB_REASON_OOPS, err, regs);
#endif  /* CONFIG_KDB */

        if (!regs)
                return;

        if (kexec_should_crash(current))
                crash_kexec(regs);


Thanks
Preetesh


-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@in.ibm.com] 
Sent: Thursday, May 10, 2007 9:23 PM
To: Preetesh Parekh
Cc: kexec@lists.infradead.org
Subject: Re: kexec and kdb

On Thu, May 10, 2007 at 03:10:16PM -0700, Preetesh Parekh wrote:
> Hi,
> 
> I have a question about kexec and kdb. Please advice or point me to
the
> right mailing list that can answer this.
> 
> I have a linux 2.6.20 kernel (patched with kdb patches) on i686
system.
> I have setup a crash kernel using "kexec -p" command which is working
> very well. I tested this by triggering a crash by using "echo c >
> /proc/sysrq-trigger" command. 
> 
> The requirement is to allow kdb to invoke first after the kernel crash
> which is not happening now (The system directly gets booted with the
> dump kernel). 
> 

crash_kexec() is the entry point for dump capture start process. I think
before that you need to put the KDB entry point so that upon a crash
control first goes to kdb.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

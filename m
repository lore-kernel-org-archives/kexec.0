Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173021pub.verizon.net ([206.46.173.21])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMHMe-00029P-1r
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 15:41:37 +0000
Received: from serve.minyard.net ([173.57.176.17]) by vms173021.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul
 16 2014))
 with ESMTPA id <0O1B002UX7K8AG10@vms173021.mailsrvcs.net> for
 kexec@lists.infradead.org; Thu, 21 Jan 2016 09:40:56 -0600 (CST)
Subject: Re: [RFC PATCH 1/4] purgatory/ipmi: Support BMC watchdog timer
 start/stop in purgatory
References: <20160120103734.4234.64015.stgit@softrs>
 <20160120103736.4234.69214.stgit@softrs>
From: Corey Minyard <minyard@acm.org>
Message-id: <56A0FC07.3020507@acm.org>
Date: Thu, 21 Jan 2016 09:40:55 -0600
MIME-version: 1.0
In-reply-to: <20160120103736.4234.69214.stgit@softrs>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: minyard@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

A general note here.  It does not appear that you implement the
error recovery states in your state machine.  If the system fails
in the middle of doing an IPMI operation, it is likely to fail.

If you do this you will need to detect and abort any running
operation.  Implementing the full state machine is probably the
best approach, it should handle this, though it is rather complex.

-corey

On 01/20/2016 04:37 AM, Hidehiro Kawai wrote:
> This patch adds an interface to BMC via KCS I/F and a functionality
> to start/stop BMC watchdog timer in purgatory.  Starting the watchdog
> timer is useful to automatically reboot the server when we fail to
> boot the second kernel.  Stopping the watchdog timer is useful to
> prevent the second kernel from being stopped by the watchdog timer
> enabled while the first kernel is running.
>
> If you specify --ipmi-wdt-start or --ipmi-wdt-stop option to kexec
> command, BMC's watchdog timer will start or stop respectively while
> executing purgatory.  You can't specify the both options at the same
> time.  The start operation doesn't change the parameters of the
> watchdog timer such as initial counter and action, you need to set
> those parameters in the first OS.  On the other hand, the stop
> operation changes the parameters.  You need to reset them when you
> want to reuse the watchdog timer.
>
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> ---
>   kexec/ipmi.h                  |    9 ++
>   kexec/kexec.c                 |   18 +++
>   kexec/kexec.h                 |    6 +
>   purgatory/Makefile            |    1
>   purgatory/include/purgatory.h |    3 +
>   purgatory/ipmi.c              |  232 +++++++++++++++++++++++++++++++++++++++++
>   purgatory/purgatory.c         |    4 +
>   7 files changed, 272 insertions(+), 1 deletion(-)
>   create mode 100644 kexec/ipmi.h
>   create mode 100644 purgatory/ipmi.c
>
> diff --git a/kexec/ipmi.h b/kexec/ipmi.h
> new file mode 100644
> index 0000000..395a2c7
> --- /dev/null
> +++ b/kexec/ipmi.h
> @@ -0,0 +1,9 @@
> +#ifndef IPMI_H
> +#define IPMI_H
> +
> +/* Options for IPMI code excuted in purgatory */
> +#define IPMI_WDT_DO_NOTHING	0
> +#define IPMI_WDT_START		(1 << 0)
> +#define IPMI_WDT_STOP		(1 << 1)
> +
> +#endif /* IPMI_H */
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index f0bd527..8a8f268 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -49,6 +49,7 @@
>   #include "kexec-sha256.h"
>   #include "kexec-zlib.h"
>   #include "kexec-lzma.h"
> +#include "ipmi.h"
>   #include <arch/options.h>
>   
>   unsigned long long mem_min = 0;
> @@ -57,6 +58,7 @@ static unsigned long kexec_flags = 0;
>   /* Flags for kexec file (fd) based syscall */
>   static unsigned long kexec_file_flags = 0;
>   int kexec_debug = 0;
> +int opt_ipmi_wdt = IPMI_WDT_DO_NOTHING;
>   
>   void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
>   {
> @@ -643,6 +645,10 @@ static void update_purgatory(struct kexec_info *info)
>   	if (!info->rhdr.e_shdr) {
>   		return;
>   	}
> +
> +	elf_rel_set_symbol(&info->rhdr, "ipmi_wdt", &opt_ipmi_wdt,
> +			   sizeof(opt_ipmi_wdt));
> +
>   	arch_update_purgatory(info);
>   	memset(region, 0, sizeof(region));
>   	sha256_starts(&ctx);
> @@ -1345,6 +1351,12 @@ int main(int argc, char *argv[])
>   		case OPT_KEXEC_FILE_SYSCALL:
>   			/* We already parsed it. Nothing to do. */
>   			break;
> +		case OPT_IPMI_WDT_START:
> +			opt_ipmi_wdt |= IPMI_WDT_START;
> +			break;
> +		case OPT_IPMI_WDT_STOP:
> +			opt_ipmi_wdt |= IPMI_WDT_STOP;
> +			break;
>   		default:
>   			break;
>   		}
> @@ -1370,6 +1382,12 @@ int main(int argc, char *argv[])
>   		    "\"--mem-max\" parameter\n");
>   	}
>   
> +	if ((opt_ipmi_wdt & IPMI_WDT_START) &&
> +	    (opt_ipmi_wdt & IPMI_WDT_STOP)) {
> +		die("You can't specify both --ipmi-wdt-start and "
> +		    "--ipmi-wdt-stop\n");
> +	}
> +
>   	fileind = optind;
>   	/* Reset getopt for the next pass; called in other source modules */
>   	opterr = 1;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index c02ac8f..4638866 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -224,7 +224,9 @@ extern int file_types;
>   #define OPT_LOAD_PRESERVE_CONTEXT 259
>   #define OPT_LOAD_JUMP_BACK_HELPER 260
>   #define OPT_ENTRY		261
> -#define OPT_MAX			262
> +#define OPT_IPMI_WDT_START	262
> +#define OPT_IPMI_WDT_STOP	263
> +#define OPT_MAX			264
>   #define KEXEC_OPTIONS \
>   	{ "help",		0, 0, OPT_HELP }, \
>   	{ "version",		0, 0, OPT_VERSION }, \
> @@ -244,6 +246,8 @@ extern int file_types;
>   	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
>   	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
>   	{ "debug",		0, 0, OPT_DEBUG }, \
> +	{ "ipmi-wdt-start",	0, 0, OPT_IPMI_WDT_START }, \
> +	{ "ipmi-wdt-stop",	0, 0, OPT_IPMI_WDT_STOP }, \
>   
>   #define KEXEC_OPT_STR "h?vdfxyluet:ps"
>   
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index 2b5c061..ae1d2bd 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -9,6 +9,7 @@
>   
>   PURGATORY = purgatory/purgatory.ro
>   PURGATORY_SRCS =
> +PURGATORY_SRCS += purgatory/ipmi.c
>   PURGATORY_SRCS += purgatory/purgatory.c
>   PURGATORY_SRCS += purgatory/printf.c
>   PURGATORY_SRCS += purgatory/string.c
> diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
> index 788ce49..9b9ffbe 100644
> --- a/purgatory/include/purgatory.h
> +++ b/purgatory/include/purgatory.h
> @@ -1,11 +1,14 @@
>   #ifndef PURGATORY_H
>   #define PURGATORY_H
>   
> +extern int ipmi_wdt;
> +
>   void putchar(int ch);
>   void sprintf(char *buffer, const char *fmt, ...)
>   	__attribute__ ((format (printf, 2, 3)));
>   void printf(const char *fmt, ...) __attribute__ ((format (printf, 1, 2)));
>   void setup_arch(void);
>   void post_verification_setup_arch(void);
> +void ipmi_wdt_start_stop(void);
>   
>   #endif /* PURGATORY_H */
> diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
> new file mode 100644
> index 0000000..0acb853
> --- /dev/null
> +++ b/purgatory/ipmi.c
> @@ -0,0 +1,232 @@
> +#include <sys/io.h>
> +#include <purgatory.h>
> +#include "../kexec/ipmi.h"
> +
> +#define KCS_PORT_DEFAULT	0xca2
> +#define KCS_PORT_DATA		(kcs_port + 0)
> +#define KCS_PORT_STATUS		(kcs_port + 1)
> +#define KCS_PORT_CMD		(kcs_port + 1)
> +
> +#define KCS_STATUS_OBF		0x1
> +#define KCS_STATUS_IBF		0x2
> +
> +#define KCS_CMD_WRITE_START	0x61
> +#define KCS_CMD_WRITE_END	0x62
> +#define KCS_CMD_READ		0x68
> +
> +#define GET_STATUS_STATE(status) (((status) >> 6) & 0x03)
> +#define KCS_IDLE_STATE	0x0
> +#define KCS_READ_STATE	0x1
> +#define KCS_WRITE_STATE	0x2
> +#define KCS_ERROR_STATE	0x3
> +
> +int kcs_port = KCS_PORT_DEFAULT;
> +int ipmi_wdt = IPMI_WDT_DO_NOTHING;
> +
> +/* IPMI command to start BMC watchdog timer */
> +const unsigned char cmd_start_wdt[] = {
> +	0x06 << 2,	/* App */
> +	0x22,		/* Reset Watchdog Timer */
> +};
> +
> +/* IPMI command to stop BMC watchdog timer */
> +const unsigned char cmd_stop_wdt[] = {
> +	0x06 << 2,	/* App */
> +	0x24,		/* Set Watchdog Timer Command */
> +	0x84,		/* Timer Use: don't log, and SMS/OS use */
> +	0x00,		/* Timer Actions: no action */
> +	0x00,		/* Pre-timeout interval: 0 */
> +	0x10,		/* Timer Use Expiration flag clear: SMS/OS */
> +	0xff,		/* Initial countdown value: 0xffff */
> +	0xff,
> +};
> +
> +static inline unsigned char read_status(void)
> +{
> +	return inb(KCS_PORT_STATUS);
> +}
> +
> +unsigned char wait_out(void)
> +{
> +	unsigned char status;
> +
> +	do {
> +		status = read_status();
> +	} while ((status & KCS_STATUS_OBF) == 0);
> +
> +	return status;
> +}
> +
> +unsigned char wait_in(void)
> +{
> +	unsigned char status;
> +
> +	do {
> +		status = read_status();
> +	} while (status & KCS_STATUS_IBF);
> +
> +	return status;
> +}
> +
> +unsigned char read_data(void)
> +{
> +	wait_out();
> +	return inb(KCS_PORT_DATA);
> +}
> +
> +void clear_obf(void)
> +{
> +	if (inb(KCS_PORT_STATUS) & KCS_STATUS_OBF)
> +		read_data();
> +}
> +
> +unsigned char write_data(unsigned char byte)
> +{
> +	clear_obf();
> +	outb(byte, KCS_PORT_DATA);
> +	return wait_in();
> +}
> +
> +unsigned char write_cmd(unsigned char byte)
> +{
> +	clear_obf();
> +	outb(byte, KCS_PORT_CMD);
> +	return wait_in();
> +}
> +
> +/*
> + * Issue a given IPMI command via KCS I/F.
> + *
> + * Return 0 on success, otherwise -1.
> + */
> +int write_ipmi_cmd(const unsigned char *cmd, int size)
> +{
> +	unsigned char status;
> +	int i;
> +
> +	wait_in();
> +	status = write_cmd(KCS_CMD_WRITE_START);
> +	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
> +		return -1;
> +
> +	for (i = 0; i < size - 1; i++) {
> +		status = write_data(cmd[i]);
> +
> +		if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
> +			return -1;
> +	}
> +
> +	/* last write */
> +	status = write_cmd(KCS_CMD_WRITE_END);
> +	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
> +		return -1;
> +
> +	write_data(cmd[i]);
> +
> +	return 0;
> +}
> +
> +/*
> + * Read result bytes for the previously issued IPMI command.
> + *
> + * Return the completion code, which is 0 on success.  Otherwise, return
> + * non-zero value.
> + */
> +unsigned char read_result(void)
> +{
> +	unsigned char state;
> +	unsigned char data[4] = { 0 };
> +	int count = 0;
> +
> +	while (1) {
> +		state = GET_STATUS_STATE(wait_in());
> +		if (state == KCS_READ_STATE) {
> +			data[count] = read_data();
> +			outb(KCS_CMD_READ, KCS_PORT_DATA);
> +		} else if (state == KCS_IDLE_STATE) {
> +			data[count] = read_data();
> +			break;
> +		} else {
> +			/*
> +			 * Error! Set 0xff (unspecified error) as the
> +			 * completion code.
> +			 */
> +			data[2] = 0xff;
> +			break;
> +		}
> +
> +		/*
> +		 * We are interested only in the completion code in the
> +		 * 3rd byte. Skip the following bytes.
> +		 */
> +		if (count < 3)
> +			count++;
> +	}
> +
> +	return data[2]; /* Return completion code */
> +}
> +
> +/*
> + * Issue one IPMI command and check the result.
> + *
> + * Return 0 on success, otherwise -1.
> + */
> +int issue_ipmi_cmd(const unsigned char *cmd, int size)
> +{
> +	int i, ret;
> +	unsigned char comp_code;
> +
> +	/*
> +	 * Retry 3 times at most on error.
> +	 *
> +	 * write_ipmi_cmd() issues WRITE_START KCS command at the beginning,
> +	 * which aborts the ongoing IPMI command and starts new one.  So
> +	 * basically, write_ipmi_cmd() will succeed anytime.
> +	 *
> +	 * This command abort can fail on some BMC depending on its KCS I/F
> +	 * state, and  we get ERROR_STATE from the status register in that
> +	 * case.  However, there is no problem.  We can recover it by
> +	 * simply retrying from writing WRITE_START KCS command.
> +	 */
> +	for (i = 0; i < 3; i++) {
> +		ret = write_ipmi_cmd(cmd, size);
> +		if (ret < 0)
> +			continue;
> +
> +		comp_code = read_result();
> +		if (comp_code == 0)
> +			break; /* succeeded */
> +	}
> +
> +	return (i < 3) ? 0 : -1;
> +}
> +
> +int do_start_wdt(void)
> +{
> +	int ret;
> +
> +	printf("IPMI: starting watchdog timer...");
> +	ret = issue_ipmi_cmd(cmd_start_wdt, sizeof(cmd_start_wdt));
> +	printf("done\n");
> +
> +	return ret;
> +}
> +
> +int do_stop_wdt(void)
> +{
> +	int ret;
> +
> +	printf("IPMI: stopping watchdog timer...");
> +	ret = issue_ipmi_cmd(cmd_stop_wdt, sizeof(cmd_stop_wdt));
> +	printf("done\n");
> +
> +	return ret;
> +}
> +
> +void ipmi_wdt_start_stop(void)
> +{
> +	if (ipmi_wdt & IPMI_WDT_START)
> +		do_start_wdt();
> +	else if (ipmi_wdt & IPMI_WDT_STOP)
> +		do_stop_wdt();
> +}
> diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
> index 3bbcc09..f60879d 100644
> --- a/purgatory/purgatory.c
> +++ b/purgatory/purgatory.c
> @@ -48,5 +48,9 @@ void purgatory(void)
>   			/* loop forever */
>   		}
>   	}
> +
> +	if (ipmi_wdt)
> +		ipmi_wdt_start_stop();
> +
>   	post_verification_setup_arch();
>   }
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
